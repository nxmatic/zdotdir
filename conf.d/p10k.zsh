#
# powerlevel10k - romkatv/powerlevel10k prompt
#

(( $+functions[prompt_powerlevel9k_teardown] )) || return 1

# Set the prompt config
local prompt_config
zstyle -s ':zsh:prompt:powerlevel10k' config prompt_config
if [[ -n "$prompt_config" ]]; then
  # ONE theme directory: plugins/prompt/themes is the maintained one — it holds
  # nxmatic.p10k.zsh, which rcs/zshrc.zsh sources unconditionally. $ZDOTDIR/themes held a
  # second, older copy of lean/pure (2023-04-21 against 2023-04-23, lean against
  # lean_8colors) that nothing could reach, because this zstyle is never set — so the two
  # trees drifted unnoticed for two years.
  prompt_config=$ZDOTDIR/plugins/prompt/themes/${prompt_config}.p10k.zsh

  # To customize prompt, run `p10k configure` or edit ${ZDOTDIR:-~}/.p10k.zsh.
  [[ -f $prompt_config ]] || prompt_config=${ZDOTDIR:-~}/.p10k.zsh
  source $prompt_config
fi
