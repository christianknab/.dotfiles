if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/go/bin

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # disabled since we are using Powerlevel10k manually
plugins=(git)
source $ZSH/oh-my-zsh.sh

source ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ${HOME}/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

source ${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then 
#   tmux attach -t main || tmux new -s main
# fi

setopt GLOB_DOTS
zstyle ':completion:*' special-dirs false
zstyle ':completion:*:cd:*' tag-order 'directories'

# alias rcat="command cat"
# alias cat="bat"
# alias ls="eza --group-directories-first --icons=auto"
# alias la="ls -A"
# alias lt="eza --tree --level=2 --long --icons --git"
# alias lta="lt -a"
# alias cd="zd"
# alias myrsync="rsync -ah --partial --info=progress2,stats2"

# zd() {
#   if [ $# -eq 0 ]; then
#     builtin cd ~ && return
#   elif [ -d "$1" ]; then
#     builtin cd "$1"
#   else
#     z "$@"
#   fi
# }
# compdef _cd zd

# open() {
#   nohup xdg-open "$@" >/dev/null 2>&1 &
# }
