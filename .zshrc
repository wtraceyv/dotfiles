# Path to your oh-my-zsh installation.
export ZSH="/home/walter/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# robbyrussell agnoster half-life cmd-prompt garyblessington
# ZSH_THEME="garyblessington"
# ZSH_THEME="../../.my-zsh-themes/guezwhoz/021011"
ZSH_THEME="../../.my-zsh-themes/robbyrussell"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

# Standard plugins can be found in $ZSH/plugins/
# insert 'vi-mode' (with whitespace) to get vim mode in shell
plugins=(git vi-mode tmux)
ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

# default browser?
BROWSER=chromium

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
alias li='ls -lh'
alias neoa='neofetch --ascii_distro arch'
alias neog='neofetch --ascii_distro gentoo'
alias sus='systemctl suspend'
alias vi="vim"
alias xargs='xargs ' # now using xargs will give me access to all these aliases
alias gits='git status'
alias token-git-copy='cd ~/git && ls | grep token | xargs cat | xclip -sel c && cd -'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias configs='config status'
alias configStage="configs | grep modified | cut -d ':' -f 2 | tr -d \" \" | xargs config add"
alias configUnstage="configs | grep modified | cut -d ':' -f 2 | tr -d \" \" | xargs config restore --staged"
alias py="python3"

alias mst="TZ='America/Denver' date"

# need specific tools/needs for these
alias pic='killall picom && (picom >/dev/null &) && echo success || (picom >/dev/null &)'
alias temps="watch sensors"
alias smooth='nvidia-force-comp-pipeline'
alias matrix='cmatrix -sa -u 10 -C cyan'
alias red="redshift -O 4000K -b .85:.85 -v"
alias nored="redshift -x -v"
alias wp="feh -g 640x480 -d -S filename ~/.wallpapers -A 'feh --bg-scale ~/.wallpapers/%n'"

function grun {
	g++ -g --std=c++20 $1
	./a.out
}

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

function gnasm {
	if [[ $# -lt 1 ]]
	then
		echo "Supply a file of assembly"
		return
	fi

	nasm -f elf32 -g $1 -o inter.o
	ld -m elf_i386 -s -g inter.o
	rm inter.o
	./a.out
}


# activate syntax highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# have fzf for these
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

function three {
	# manjaro home screen setup
	smooth && pic && source .bin/screenlayout/home.sh && red
}

function three-basic {
	source .bin/screenlayout/home.sh && red
}

space-invaders
