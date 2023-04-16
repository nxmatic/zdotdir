# Check for starship
if ! (( $+commands[starship] )); then
  echo >&2 "Starship not found. See https://starship.rs to install."
  return 1
fi

# Set Zsh prompt options.
setopt prompt_subst  # Expand parameters in prompt.

# Set starship theme
local ZSH_THEME=$ZSH_THEME
if [[ -z $ZSH_THEME ]]; then
  zstyle -s ':prezto:module:prompt' theme 'ZSH_THEME'
fi
if [[ -n "${ZSH_THEME}" ]]; then
  local theme=${XDG_CONFIG_HOME:-$HOME/.config}/starship/${ZSH_THEME}.toml
  [[ -e $theme ]] && export STARSHIP_CONFIG=$theme
fi

# Initialize Starship prompt.
source <(starship init zsh --print-full-init)

# Set 2 space indent for each new level in a multi-line script
# This can then be overridden by a prompt, but is a better default than zsh's
PS2='${${${(%):-%_}//[^ ]}// /  }    '
