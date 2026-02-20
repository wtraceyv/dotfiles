#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
ORANGE='\033[0;38;5;208m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

display_dot() {
	local color=$1
	local dot="●"

	case "$color" in
		red)
			echo -ne "${RED}${dot}${NC} "
			;;
		yellow)
			echo -ne "${YELLOW}${dot}${NC} "
			;;
		orange)
			echo -ne "${ORANGE}${dot}${NC} "
			;;
		green)
			echo -ne "${GREEN}${dot}${NC} "
			;;
		*)
			echo ""
			;;
	esac
}

parse_git_changes() {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo ""
		return
	fi
	
	GIT_STATUS=$(git status --porcelain 2>/dev/null)

	if [ -n GIT_STATUS ]; then
		if grep -q ' . ' <<< "$GIT_STATUS" || grep -q ' M' <<< "$GIT_STATUS" || grep -q 'D ' <<< "$GIT_STATUS"; then
			display_dot "red"
		elif grep -q '?? ' <<< "$GIT_STATUS" || grep -q 'MM ' <<< "$GIT_STATUS"; then
			display_dot "orange"
		elif grep -qE '^[AMD]' <<< "$GIT_STATUS"; then
			display_dot "yellow"
		else
			display_dot "green"
		fi
	fi
}

# don't know if this works; make it work pls
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# must have fzf
source ~/.bin/util/fzf/key-bindings.bash
source ~/.bin/util/fzf/completion.bash

alias c='clear'
alias e='exit'
alias ls='ls --color=auto'
alias l='ls -lah'
alias li='ls -lh'
alias grep='grep --color=auto'
alias ..="cd .."
alias k="minikube kubectl --" # TODO: maybe real kubectl
alias df='df -h' # human-readable sizes
alias ff='fastfetch'
alias neoa='neofetch --ascii_distro arch'
alias neog='neofetch --ascii_distro gentoo'
alias sus='systemctl suspend'
alias vi="vim"
alias xargs='xargs ' # now using xargs will give me access to all these aliases
alias gits='git status'
alias token-git-copy='cd ~/git && ls | grep token | xargs cat | xclip -sel c && cd -'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias configs='config status'
alias py="python3"

# my easy unspecial bash prompt
export PS1='\[\e[0;31m\]wa11-e\[\e[0m\]:\w\[\e[0;32m\]$(parse_git_branch) $(parse_git_changes)\[\e\033[0;36m\]λ\[\e[0m\] '

space-invaders
#colorpanes

