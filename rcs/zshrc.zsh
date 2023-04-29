# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# ZFunctions
source $ZDOTDIR/plugins/zfunctions/zfunctions.plugin.zsh

zdotdebug zrcload

# Libs
for zfile in $ZDOTDIR/lib/*.zsh(N); source $zfile; unset zfile

zrcload ${ZDOTDIR}/conf.d/lib

# plugins
function {
    local _customplugins
    local _custompluginsdefer

    zstyle -a ':zsh_custom:plugins' load '_customplugins'
    zstyle -a ':zsh_custom:plugins:defer' load '_custompluginsdefer'

    declare -au myplugins

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
	$customplugins
	
	_defer_
	abbreviations
	syntax-highlighting
	autosuggestions
	history-substring-search
	$cusyom
    )

    source <(plugin-script $myplugins)
}

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
