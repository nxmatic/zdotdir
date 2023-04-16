#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

# Load zstyles.
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# get minmalist zsh_unplugged plugin manager
[[ -d $ZDOTDIR/.unplugged ]] ||
  git clone git@github.com:mattmc3/zsh_unplugged $ZDOTDIR/.unplugged
source $ZDOTDIR/.unplugged/unplugged.zsh
ZPLUGINDIR=$ZDOTDIR/plugins/.external

# get frameworks
utils=(
  ohmyzsh/ohmyzsh
  sorin-ionescu/prezto
  romkatv/zsh-bench
  romkatv/gitstatus
)
plugin-clone $utils

# framework vars
OMZLIB=$ZPLUGINDIR/ohmyzsh/lib
OMZ=$ZPLUGINDIR/ohmyzsh/plugins
PREZTO=$ZPLUGINDIR/prezto/modules
PREZTORC=$ZPLUGINDIR/prezto/runcoms

# load plugins
plugins=(
  # remote plugins
  mattmc3/zman
  #agkozak/zsh-z
  rupa/z

  # framework plugins
  $OMZLIB/clipboard.zsh
  $OMZ/copyfile
  $OMZ/copypath
  $OMZ/copybuffer
  $OMZ/magic-enter
  $OMZ/extract
  $PREZTORC/zprofile
  $PREZTO/terminal
  $PREZTO/editor
  $PREZTO/history
  $PREZTO/directory

  # local plugins
  color
  homebrew
  python
  utility
  zfunctions
  xdg

  # prompt
  # sindresorhus/pure
  starship

  # last
  confd
  zsh-users/zsh-completions
  $PREZTO/completion

  # deferred
  romkatv/zsh-defer
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)
plugin-load $plugins

# Load zaliases.
[[ -f $ZDOTDIR/.zaliases ]] && source $ZDOTDIR/.zaliases

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
