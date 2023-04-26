# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Libs
for zfile in $ZDOTDIR/lib/*.zsh(N); source $zfile
unset zfile

# plugins
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

  _defer_
  abbreviations
  syntax-highlighting
  autosuggestions
  history-substring-search
)
plugin-script $myplugins > $ZDOTDIR/.zplugins
source $ZDOTDIR/.zplugins

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
