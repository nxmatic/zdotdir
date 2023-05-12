#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

local _this=${0:t:r}

#[p[ -n "${_this}-marker" ]] &&
#  return
# declare -g ${_this}-marker=${0}

defun _${_this}() {
  local _fndir &&
      for _fndir in ${1}/{,**/*}(N/); do
	  fpath=("$_fndir" $fpath)
	  autoload -Uz $fpath[1]/*(.:t)
	  symlinks=( ${fpath[1]}/*(@N:t) )
	  [[ -n "$symlinks" ]] &&
	      autoload -Uz $symlinks &&
	      echo "should load $symlinks"
      done &&
      unset _fndir
}

# Load plugins functions.
_${_this} "${0:A:h}/functions"

# Set ZFUNCDIR.
: ${ZFUNCDIR:=$ZSH_CUSTOM/functions}
[[ -d "$ZFUNCDIR" ]] || ZFUNCDIR=$ZDOTDIR/functions

# Load zfunctions subdirs.
_${_this} "${ZFUNCDIR}"
