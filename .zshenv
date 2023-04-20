#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}

export ZDOTDIR=~/.config/zsh
export DOTFILES=~/.config/dotfiles

# Use .zprofile for remaining environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi
