#!/bin/bash

# ------ Pretty color constants -- #

# Reset
NC='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

options=$1

function sectionBreak {
	echo '********************'
}

# ------ Parse init command -- #

echo -e "${Purple}Parse install options..${NC}"
echo -e "Arg given: ${Green}${options}${NC}"

if [[ $options = *'h'* ]]; then
	echo "Argument contained 'h' for help."
	echo 
	echo -e "Usage: ${Cyan}new-install <[a|d][gtcw...]>${NC}"
	echo
	echo "Arguments are given as one string with identifying letters."
	echo "Always include either a or d to indicate arch-based vs debian-based package manager. "
	echo "Otherwise, include any of the following for more:"
	echo "  g: git and configuration setup"
	echo "  t: terminal utilities"
	echo "  c: creative applications, which are relatively large and graphics-based"
	echo "  w: window management utilities"

	exit
fi

if [[ $options = *'a'* ]]; then
	echo -e "You have indicated you are ${Cyan}arch-based (use pacman/AUR).${NC}"
fi
if [[ $options = *'d'* ]]; then
	echo -e "You have indicated you are ${Cyan}debian-based (use apt).${NC}"
fi
if [[ $options = *'g'* ]]; then
	echo -e "You have optioned to setup ${Cyan}git and local configurations.${NC}"
fi
if [[ $options = *'t'* ]]; then
	echo -e "You have optioned to install ${Cyan}terminal utilities.${NC}"
fi
if [[ $options = *'c'* ]]; then
	echo -e "You have optioned to install ${Cyan}creative utilities.${NC}"
fi
if [[ $options = *'w'* ]]; then
	echo -e "You have optioned to install ${Cyan}window management utilities.${NC}"
fi

# https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script/27875395#27875395
read -p "Is this what you want to install (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo 'Continuing install.'
		sectionBreak
    ;;
    * )
        echo 'Exiting'; exit
    ;;
esac

# i like arch; defaulting to arch
distroInstallPhrase='sudo pacman -Syu'
if [[ $options = *'d'* ]]; then
	distroInstallPhrase='sudo apt install'
fi

# ------ Functions for later steps -- #

function createOrMakeExecutableFolders {
	rmdir $HOME/Pictures
	rmdir $HOME/Videos

	mkdir $HOME/Documents/Vault
	mkdir $HOME/Documents/Media/Audio
	mkdir $HOME/Documents/Media/Videos
	mkdir $HOME/Documents/Media/Images
	mkdir $HOME/Documents/Media/Models
	mkdir $HOME/pass
	mkdir $HOME/git
	mkdir $HOME/non-pac
	mkdir $HOME/non-pac/imgapp
	mkdir $HOME/non-pac/AUR
	mkdir $HOME/non-pac/snap

	sudo chmod +x $HOME/.bin
	sudo chmod +x $HOME/.bin/fun
	sudo chmod +x $HOME/.bin/fun/*
	sudo chmod +x $HOME/.bin/screenlayout
	sudo chmod +x $HOME/.bin/screenlayout/*
	sudo chmod +x $HOME/.bin/new-install-scripts
	sudo chmod +x $HOME/.bin/new-install-scripts/*
	sudo chmod +x $HOME/.bin/util
	sudo chmod +x $HOME/.bin/util/*
}

function setupGitAndConfigs {
	echo -e "${Purple}Downloading initial configs.${NC}"

	# from git instructions
	echo ".cfg" >> $HOME/.gitignore
	git clone --bare https://github.com/wtraceyv/dotfiles.git $HOME/.cfg
	alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
	config config --local status.showUntrackedFiles no
	config checkout manjaro

	echo "If you get errors about file conflicts, delete the local files causing the conflict."
	echo -e "Then rerun the command ${Green}config checkout manjaro${NC} or applicable branch."

	echo -e "${Purple}Cloning other git repos..${NC}"
	git clone https://github.com/wtraceyv/pass.git ~/pass
	git clone https://github.com/wtraceyv/obsidian-vault.git ~/Documents/Vault

}

# TODO: make it run real command
function installWithPackageManager {
	packages=("$@")
	for i in "${packages[@]}"
	do
		# echo "$distroInstallPhrase $i"
		echo "$distroInstallPhrase $i"
	done
}

function installFromAUR {
	packages=("$@")
	for i in "${packages[@]}"
	do
		read -p "Fetch and install $i now (y/n)?" answer
		case ${answer:0:1} in
			y|Y )
				# TODO: make it actually pull + makepkg -si
				echo "git clone https://aur.archlinux.org/$i.git $HOME/non-pac/AUR"
				echo "makepkg -si $HOME/non-pac/AUR/$i"
			;;
			* )
				echo -e "${Purple}Not installing $i.${NC}"
			;;
		esac

	done
}


# ------------------------------------ #

if [[ $options = *'g'* ]]; then
	# -- setup git going forward and password access,
	echo -e "${Cyan}You will need a valid github token for this machine to continue${NC}"
	read -p "Enter your git token to save it for later (you will have to enter it again in a moment): " token
	# TODO: actually save token
	echo -e "${Cyan}Saving token: ${token}${NC}"

	# TODO: setupGitAndConfigs() call goes here
	# TODO: createOrMakeExecutableFolders() call goes here
	echo -e "${Purple}setupGitAndConfigs()${NC}"
	echo -e "${Purple}createOrMakeExecutableFolders()${NC}"

	sectionBreak
fi

# ------ Terminal utilities for any system, mostly graphics agnostic -- #

if [[ $options = *'t'* ]]; then
	echo -e "${Purple}Installing terminal utilities.${NC}"

	terminalUtils=('zsh' 'tmux' 'vim' 'fastfetch' 'fzf' 'btop' 'keepassxc' 'redshift' 'feh' 'cmatrix')
	installWithPackageManager "${terminalUtils[@]}"

	# oh-my-zsh and syntax highlighting
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	zsh-highlighting-pack=('zsh-syntax-highlighting')
	installWithPackageManager "${zsh-highlighting-pack[@]}"

	# optional add home term emulator
	promptedTerminalUtils=('alacritty')
	read -p "Do you want to install alt term emulator alacritty (y/n)? " answer
	case ${answer:0:1} in
		y|Y )
			installWithPackageManager "${promptedTerminalUtils[@]}"
		;;
		* )
			echo 'Ok, not installing alacritty.'
		;;
	esac

	sectionBreak
fi

# ------ install larger graphical programs for art and recreation -- #

if [[ $options = *'c'* ]]; then
	echo -e "${Purple}Installing creative graphical utilities.${NC}"
	# TODO: force proprietary code-oss regardless of distro for vscode, else open source one?
	largeGraphicalUtils=('gimp' 'krita' 'inkscape' 'darktable' 'ardour' 'blender' 'xf86-input-wacom' 'picom' 'thunar')
	installWithPackageManager "${largeGraphicalUtils[@]}"

	PS3="Select a browser to install: "
	select browser in chromium firefox-developer-edition brave-browser none; do
		case $browser in
			chromium)
			echo "$distroInstallPhrase chromium"
			break
			;;
			firefox-developer-edition)
			echo "$distroInstallPhrase firefox-developer-edition"
			break
			;;
			brave-browser)
			echo "$distroInstallPhrase brave-browser"
			break
			;;
			none)
			echo "Okay, not installing any browsers right now."
			break
			;;
			*)
			echo "Invalid option $REPLY"
			;;
		esac
	done
	sectionBreak

	fetchYourOwnImageapps=('Obsidian' 'Balena Etcher')
	echo -e "If you need them, fetch below image apps online and place at ${Cyan}$HOME/non-pac/imgapp${NC}"
	for i in "${fetchYourOwnImageapps[@]}"
	do
		echo "- $i"
	done
	sectionBreak
fi

# ------ install AUR programs I may want if I'm on arch -- #

# TODO: How to add these for debian-based

if [[ $options = *'a'* ]]; then
	read -p "Do you want to install previous programs from the AUR (y/n)? " answer
	case ${answer:0:1} in
		y|Y )
			AURprograms=('powerline-fonts-git' 'nerd-fonts-arimo' 'visual-studio-code-bin' 'qimgv' 'spotify-player')
			installFromAUR "${AURprograms[@]}"
			
			sectionBreak
		;;
		* )
			echo 'Ok, not installing anything from the AUR.'
		;;
	esac	
fi


# ------ to install awesome wm programs to go with configs -- #

if [[ $options = *'w'* ]]; then
	echo -e "${Purple}Installing window manager utilities.${NC}"
	awesomewmUtils=('awesome' 'rofi' 'arandr')
	installWithPackageManager "${awesomewmUtils[@]}"

	sectionBreak
fi
