# Hyperbind

Bind zsh commands to **Hyper + key** shortcuts.

Hyperbind is meant to be used on macOS with [Hyperkey](https://hyperkey.app/), which turns Caps Lock into a "Hyper" modifier. Press Hyper + a key and Hyperbind runs a command in your current shell, or opens a completion menu.

## Requirements

- macOS with [Hyperkey](https://hyperkey.app/)
- zsh
- A terminal that reports modified keys as CSI u sequences (`ESC [ <code> ; 8 u`)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab), for `complete` mode only

## Installation

Clone the repo and source the script from your `~/.zshrc`:

```zsh
source "$HOME/Code/hyperbind/hyperbind.sh"
```

## Usage

```zsh
hyperbind <key> run|complete <command>
```

- **`run`** runs `<command>` right away in the current shell, so commands that `cd` keep working. Whatever you had typed at the prompt is saved and comes back afterwards.
- **`complete`** types `<command>` as a prefix and opens fzf-tab completion. If you pick something, the full command runs. If you cancel, the prompt is cleared.

## Examples

```zsh
# Hyperbind
source "$HOME/Code/hyperbind/hyperbind.sh"
hyperbind w run      'wt switch'
hyperbind z run      'zi'
hyperbind r complete 'pnpm run '
hyperbind c complete 'git switch '
```

| Shortcut  | What it does                                  |
| --------- | --------------------------------------------- |
| Hyper + W | Runs `wt switch`                              |
| Hyper + Z | Runs `zi` (zoxide interactive `cd`)           |
| Hyper + R | Opens completion for `pnpm run` scripts       |
| Hyper + C | Opens completion for `git switch` branches    |

The trailing space in `complete` commands matters: with it, fzf-tab completes the *next* argument rather than the command itself.
