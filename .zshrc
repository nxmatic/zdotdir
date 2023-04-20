#!/bin/zsh
##? .zshrc - Run on interactive Zsh session.

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

# Load zfunctions.
fpath=($ZDOTDIR/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

# get minmalist zsh_unplugged plugin manager
[[ -d $ZDOTDIR/.unplugged ]] ||
  git clone git@github.com:mattmc3/zsh_unplugged $ZDOTDIR/.unplugged
#source $ZDOTDIR/.unplugged/zsh_unplugged.zsh
source ~/Projects/mattmc3/zsh_unplugged/zsh_unplugged.zsh

# clone-only plugins
path+=$ZUNPLUG_REPOS/romkatv/zsh-bench
(( $+commands[zsh-bench] )) || plugin-clone romkatv/zsh-bench

# load plugins
plugins=(
  # Load customizations.
  $ZDOTDIR/.zstyles

  # regular plugins
  mattmc3/zfunctions
  mattmc3/zman
  rupa/z

  # oh-my-zsh plugins
  ohmyzsh/ohmyzsh/lib/clipboard.zsh
  ohmyzsh/ohmyzsh/plugins/copyfile
  ohmyzsh/ohmyzsh/plugins/copypath
  ohmyzsh/ohmyzsh/plugins/copybuffer
  ohmyzsh/ohmyzsh/plugins/magic-enter
  ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z
  ohmyzsh/ohmyzsh/plugins/extract

  # prezto
  sorin-ionescu/prezto/runcoms/zprofile
  sorin-ionescu/prezto/modules/terminal
  sorin-ionescu/prezto/modules/editor
  sorin-ionescu/prezto/modules/directory

  # zsh-utils
  belak/zsh-utils/history

  # zephyr
  mattmc3/zephyr/plugins/color
  mattmc3/zephyr/plugins/homebrew
  mattmc3/zephyr/plugins/utility
  #zshzoo/environment
  #zshzoo/terminal
  #zshzoo/editor
  #zshzoo/history
  #zshzoo/directory
  zshzoo/macos

  # local plugins
  python

  # prompt
  sindresorhus/pure
  #starship

  # last
  mattmc3/zephyr/plugins/confd
  $ZDOTDIR/.zaliases
  zsh-users/zsh-completions
  zshzoo/compinit
  zshzoo/compstyle

  # deferred
  romkatv/zsh-defer
  olets/zsh-abbr
  zdharma-continuum/fast-syntax-highlighting
  #zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)
plugin-load $plugins

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
