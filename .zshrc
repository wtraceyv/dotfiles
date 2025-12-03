# Path to your oh-my-zsh installation.
export ZSH="/home/walter/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# robbyrussell agnoster half-life cmd-prompt kali-classic garyblessington
# ZSH_THEME="agnoster"
# ZSH_THEME="../../.my-zsh-themes/guezwhoz/021011"
ZSH_THEME="../../.my-zsh-themes/kali-classic"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

# Standard plugins can be found in $ZSH/plugins/
# insert 'vi-mode' (with whitespace) to get vim mode in shell
plugins=(git vi-mode tmux)
ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

# default browser?
# BROWSER=chromium
BROWSER=firefox

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
alias k="minikube kubectl --"
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

alias mst="TZ='America/Denver' date"

# need specific tools/needs for these
alias pic='killall picom && (picom --daemon >/dev/null &) && echo success || (picom --daemon >/dev/null &)'
alias temps="watch sensors"
alias smooth='nvidia-force-comp-pipeline'
alias matrix='cmatrix -sa -u 10 -b -M "you silly billy"'
alias red="redshift -O 4000K -b .8:.8 -v"
alias nored="redshift -x -v"
alias wp="feh -g 640x480 -d -S filename ~/.wallpapers -A 'feh --bg-fill ~/.wallpapers/%n'"

# can't include gcc/c std functions with this
function gnasm {
	if [[ $# -lt 1 ]]
	then
		echo "Supply a file of assembly"
		return
	fi

	nasm -f elf32 -g $1 -o inter.o
	ld -m elf_i386 -g inter.o # -s strips the debugging symbols, but then gdb doesn't work
	rm inter.o
	./a.out
}

function wacom-setup {
	echo -n "Supply the STYLUS, and then PAD, id numbers with the command."
	echo

	xsetwacom --list devices
	xsetwacom set "$1" rotate none
	# mod HEAD-number to change mapped monitor
	xsetwacom -v --set "$1" MapToOutput "HEAD-0"

	# button 1 is center of circle, 2-9 are square buttons from top to bottom
	xsetwacom --set $2 button 1 "key ctrl z"
	
	# TODO: figure out good maps for other buttons..
}

function three {
	smooth && source ~/.bin/screenlayout/home.sh && red
}

function three-basic {
	source ~/.bin/screenlayout/home.sh && red
}


# activate syntax highlight (two places it could be that I've seen)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# have fzf for these
source ~/.bin/util/fzf/key-bindings.zsh
source ~/.bin/util/fzf/completion.zsh


# space-invaders
# colorpanes
