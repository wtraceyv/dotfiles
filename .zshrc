# Path to your oh-my-zsh installation.
export ZSH="/home/walter/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# robbyrussell agnoster half-life 
ZSH_THEME="cmd-prompt"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

# Standard plugins can be found in $ZSH/plugins/
# insert 'vi-mode' (with whitespace) to get vim mode in shell
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# default browser?
BROWSER=firefox-developer-edition

# able color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# any system
alias c='clear'
alias e='exit'
alias l='ls -lah'
alias neoa='neofetch --ascii_distro arch'
alias neog='neofetch --ascii_distro gentoo'
alias sus='systemctl suspend'
alias vi="vim"
alias gits='git status'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias configs='config status'

# compile ATT assembly with gcc
function gasm {
	if [[ $# -lt 1 ]]
	then
		echo "Supply a file of assembly"
		return
	fi

	gcc -c $1 -o inter.o
	ld inter.o
	rm inter.o
	./a.out
}

# need specific tools/needs for these
alias pic='(picom >/dev/null &)'
alias temps="watch sensors"
alias smooth='nvidia-force-comp-pipeline'

# activate syntax highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
