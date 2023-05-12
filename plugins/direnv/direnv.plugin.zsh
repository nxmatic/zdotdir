#!/usr/bin/env zsh

command -v direnv >/dev/null ||
  return

eval "$(direnv hook zsh)"
