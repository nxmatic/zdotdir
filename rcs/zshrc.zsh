# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ensure we have a required xdg env
function {
  local localdir=$HOME/.local

  set -a

  XDG_DATA_HOME=${XDG_DATA_HOME:-$localdir/share}
  XDG_BIN_HOME=${XDG_BIN_HOME:-$localdir/bin}
  XDG_CACHE_HOME=${XDG_CACHE_HOME:-$localdir/.cache}
  XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
  XDG_DATA_HOME=${XDG_DATA_HOME:-$localdir/share}
  XDG_STATE_HOME=${XDG_STATE_HOME:-$localdir/state}

  set +a
}

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# ZFunctions

source $ZDOTDIR/plugins/zfunctions/zfunctions.plugin.zsh

zdot-debug enter

# Libs
for zfile in $ZDOTDIR/lib/*.zsh(N); source $zfile; unset zfile

# plugins
function {
    local _plugins
    local _defer

    zstyle -a ':zsh_custom:plugins:load' 'main'  '_plugins'
    zstyle -a ':zsh_custom:plugins:load' 'defer' '_defer'
    
    local -au myplugins

    myplugins=(
	# load plugins
	zfunctions
	prompt
	clipboard
	directory
	editor
	history
	utility
	terminal
	#z
	homebrew
	macos
	python
	completion
	$_plugins
	
	_defer_
	abbreviations
	syntax-highlighting
	autosuggestions
	history-substring-search
	$_defer
    )
    source <(plugin-script $myplugins)
}

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }

zdot-debug leave

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/plugins/prompt/themes/nxmatic.p10k.zsh.
[[ ! -f ~/.config/zsh/plugins/prompt/themes/nxmatic.p10k.zsh ]] || source ~/.config/zsh/plugins/prompt/themes/nxmatic.p10k.zsh

# pnpm
export PNPM_HOME="/Users/stephane.lacoin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
