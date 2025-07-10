#!/usr/bin/env zsh

# ensure we're loading the rcs files

[[ -z "$ZDOTDIR" ]] && 
    declare -g ZDOTDIR=${0:h} 

# redirect stderr and trace sourced files (lsof -p $$ | grep zshenv)

# [[ -n "$ZDOTDEBUG" ]] &&
#     function {
# 	source $ZDOTDIR/functions/**/zsh_stderr(N) open zshenv &&
# 	    setopt source_trace xtrace
#     }

# source rcs zshenv

source $ZDOTDIR/rcs/zshenv.zsh
#source "/Users/$USER/.local/share/cargo/env"
