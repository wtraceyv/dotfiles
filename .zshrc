# Path to your oh-my-zsh installation.
export ZSH="/home/walter/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# robbyrussell agnoster half-life cmd-prompt garyblessington
# ZSH_THEME="garyblessington"
ZSH_THEME="../../.my-zsh-themes/guezwhoz/021011"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

# Standard plugins can be found in $ZSH/plugins/
# insert 'vi-mode' (with whitespace) to get vim mode in shell
plugins=(git vi-mode tmux)
ZSH_TMUX_AUTOSTART=true

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
alias li='ls -lh'
alias neoa='neofetch --ascii_distro arch'
alias neog='neofetch --ascii_distro gentoo'
alias sus='systemctl suspend'
alias vi="vim"
alias gits='git status'
alias token-git-copy='cd ~/git && ls | grep token | xargs cat | xclip -sel c && cd -'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias configs='config status'
alias py="python3"

alias mst="TZ='America/Denver' date"

# need specific tools/needs for these
alias pic='(picom -b >/dev/null &)'
alias temps="watch sensors"
alias smooth='nvidia-force-comp-pipeline'
alias 3s='3-screens.sh && nvidia-force-comp-pipeline' #FIXME: this just don't work
alias red="redshift -O 4000K"
alias nored="redshift -x"
alias wp="feh -g 640x480 -d -S filename ~/.wallpapers -A 'feh --bg-scale ~/.wallpapers/%n'"

# Much more conveniently stage changes to config files
function configStageAll {
	cd ~
	configs | grep config | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
	configs | grep zshrc | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
	configs | grep alacritty | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
	configs | grep tmux | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
	configs | grep .my-zsh-themes | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
	configs | grep .wallpapers | cut -d ' ' -f 2- | xargs -I % sh -c 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'
}

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

# Load Angular CLI autocompletion.
source <(ng completion script)
