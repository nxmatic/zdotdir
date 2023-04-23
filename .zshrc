#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Load zfunctions.
fpath=($ZDOTDIR/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

# initialize zsh
. $ZDOTDIR/.zstyles
. $ZDOTDIR/.zaliases
zsh_plugins
zsh_history
zsh_confd

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
