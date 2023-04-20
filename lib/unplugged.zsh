ZUNPLUG_REPOS=${ZUNPLUG_REPOS:-$ZDOTDIR/plugins/.external}
if [[ ! $ZDOTDIR/.zplugins -nt $ZDOTDIR/.zshrc ]]; then
  (
    # get minmalist zsh_unplugged plugin manager
    [[ -d $ZUNPLUG_REPOS/zsh_unplugged ]] ||
      git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZUNPLUG_REPOS/zsh_unplugged

    source $ZUNPLUG_REPOS/zsh_unplugged/zsh_unplugged.zsh
    plugin-script $myplugins >| $ZDOTDIR/.zplugins
    sed -i "" -e "s|$HOME|~|g" $ZDOTDIR/.zplugins
    plugin-clone romkatv/zsh-bench
  )
fi
source $ZDOTDIR/.zplugins
