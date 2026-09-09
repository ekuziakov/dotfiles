# Dotfiles

> A reproducible macOS development environment, managed with [Dotbot](https://github.com/anishathalye/dotbot), Homebrew, and Mise.

## Quick Start

Install [Homebrew](https://brew.sh/), then bootstrap the environment:

```bash
git clone <REPO_URL> ~/.dotfiles
~/.dotfiles/install
```

The installer:

1. Initializes the Dotbot submodule.
2. Links the managed configuration into your home directory.
3. Installs the Homebrew bundle.
4. Installs tools declared in Mise.

## Default Shell

Set Fish as the default login shell after installation:

```fish
if test "$SHELL" != (command -v fish)
  command -v fish | sudo tee -a /etc/shells
  chsh -s (command -v fish)
end
```

Open a new terminal session after running the command.

## Included

| Area | Configuration |
| --- | --- |
| Editors | Neovim, Zed |
| Terminal | Ghostty, Alacritty, tmux, Zellij, Yazi |
| Shell | Fish, Zsh, Starship, Mise |
| Desktop | Karabiner-Elements, Hammerspoon |
| Development | LazyGit, OpenCode |

All configuration lives in [`configs/`](configs) and is linked to the appropriate location by Dotbot.

## Keep It Current

Re-run the installer whenever the configuration or package bundle changes:

```bash
~/.dotfiles/install
```

Packages and applications are declared in [`configs/Brewfile`](configs/Brewfile).

> [!WARNING]
> Homebrew runs with `--cleanup`. Packages installed outside the Brewfile can be removed during an update.

## Platform

macOS is the supported platform. The installer applies [`platforms/mac/settings.fish`](platforms/mac/settings.fish) system defaults on macOS and installs `build-essential` on Debian-based Linux systems.
