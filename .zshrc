task

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/go/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ptr/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration

export LANG=en_US.UTF-8

export EDITOR=emacs

# allow foot to jump between prompts with ctrl-shift-z/x
precmd() {
    print -Pn "\e]133;A\e\\"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias less='less -NFRSX'
alias ssh='ssh -Y'
alias ls='ls --color=auto'
alias ll='ls -l'
alias diff=colordiff
alias docker-clean-containers='docker rm $(docker ps -aq)'
alias dockerrun='docker run -it --rm --entrypoint ""'
alias pullff='git pull --ff-only'
alias pullr='git pull --rebase'
alias pull='pullff'
alias push='git push origin $(git branch --show-current)'
alias pushc='push -o merge_request.create -o merge_request.title="Draft: $(git branch --show-current)"'
alias amend='git commit --amend --no-edit'
alias sync-cci='centralci-sync -d ~/work -p'
alias t='tmux new-session -A -s'
alias tl='tmux list-sessions'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias buildit='glab mr note -m "build it"'
alias shipit='glab mr note -m "ship it"'
alias mergeit='glab mr note -m "merge it"'
alias mrready='glab mr update --ready'
alias mrdraft='glab mr update --draft'
alias mredit='glab mr update -d -'
alias mrlabel='glab mr update --label'
alias mrtarget='glab mr update --target-branch'
alias mrview='glab mr view --comments --system-logs'
alias mrweb='glab mr view --web'
alias mrdiff='glab mr diff'
alias mrcomment='glab mr note -m'

export MOZ_ENABLE_WAYLAND=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

