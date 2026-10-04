#
# .zlogin - execute login commands post-zshrc
#
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin

# ⛔ No keychain init here. It used to source `keychain --eval ~/.lima/_config/user`, which
# is dead twice over: Lima is retired (the fleet is Tart-only, and ~/.lima is gone), and
# the ssh agent is owned by nix-darwin-home (modules/home-manager/keychain.nix) — which
# runs it and loads the real keys. Measured: SSH_AUTH_SOCK points at ~/.keychain and
# `ssh-add -l` lists them.

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  : ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump}
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    if command mkdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null; then
      zcompile "$ZSH_COMPDUMP"
      command rmdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null
    fi
  fi
} &!
