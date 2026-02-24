# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
fastfetch
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
PATH="$HOME/.local/bin:$PATH"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt BEEP
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/elodie/.zshrc'
source ~/.zplug/init.zsh
zplug zsh-users/zsh-history-substring-search, as:plugin
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug load
autoload -Uz compinit
compinit
# End of lines added by compinstall
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(direnv hook zsh)"

