##? conf.d - Use a Fish-like conf.d directory for sourcing configs.

# Source all files in conf.d.
for _rcfile in $ZDOTDIR/conf.d/*.{z,}sh(N); do
  # ignore files that begin with ~
  case ${_rcfile:t} in '~'*) continue;; esac
  source "$_rcfile"
done
unset _rcfile
