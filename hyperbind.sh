# Run a command in the current shell (so cd works), with full terminal access
_run_here() {
  zle push-input
  eval "$1" </dev/tty
  local f; for f in $precmd_functions; do $f; done
  zle reset-prompt
}

# Type a prefix, open fzf-tab completion, run the result if something was picked
_complete_and_run() {
  local prefix=$1
  BUFFER="$prefix"
  CURSOR=$#BUFFER
  zle fzf-tab-complete
  if [[ $BUFFER != "$prefix" ]]; then
    zle accept-line
  else
    BUFFER=""
    zle reset-prompt
  fi
}

# hyperbind <key> run|complete <command>
hyperbind() {
  local key=$1 mode=$2 cmd=$3 name="_hyper_$1"
  case $mode in
    run)      functions[$name]="_run_here ${(q)cmd}" ;;
    complete) functions[$name]="_complete_and_run ${(q)cmd}" ;;
    *) print -u2 "hyperbind: unknown mode $mode"; return 1 ;;
  esac
  zle -N $name
  bindkey "^[[$(( #key ));8u" $name   # e.g. w → ^[[119;8u
}
