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

# make sure we have git and curl
eval "$distroInstallPhrase git"
eval "$distroInstallPhrase curl"

# ------ Functions for later steps -- #

function createOrMakeExecutableFolders {
	rmdir $HOME/Pictures
	rmdir $HOME/Videos
	rmdir $HOME/Public
	rmdir $HOME/Templates
	rmdir $HOME/Music
	rmdir $HOME/snap

	mkdir $HOME/Documents
	mkdir $HOME/Documents/Media
	mkdir $HOME/Documents/Media/Audio
	mkdir $HOME/Documents/Media/Videos
	mkdir $HOME/Documents/Media/Images
	mkdir $HOME/Documents/Media/Models
	mkdir $HOME/git
	mkdir $HOME/non-pac
	mkdir $HOME/non-pac/imgapp
	mkdir $HOME/non-pac/AUR

	# this all will only work if the git pull down worked
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
	git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
	git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout manjaro

	echo "If you get errors about file conflicts, delete the local files causing the conflict."
	echo -e "Then rerun the command ${Green}config checkout manjaro${NC} or applicable branch."
	echo -e "If you're not a sudoer, then: ${Green}su -${NC}, then ${Green}usermod -a -G sudo <username>${NC}"

	echo -e "${Purple}Cloning other git repos..${NC}"

	mkdir $HOME/pass
	git clone https://github.com/wtraceyv/pass.git ~/pass

	mkdir $HOME/Documents/Vault
	git clone https://github.com/wtraceyv/obsidian-vault.git ~/Documents/Vault

}

# TODO: make it run real command
function installWithPackageManager {
	packages=("$@")
	for i in "${packages[@]}"
	do
		# echo "$distroInstallPhrase $i"
		eval "$distroInstallPhrase $i"
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
				eval "git clone https://aur.archlinux.org/$i.git $HOME/non-pac/AUR"
				eval "makepkg -si $HOME/non-pac/AUR/$i"
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
	echo "$token" >> $HOME/git/aa-git-token

	# TODO: setupGitAndConfigs() call goes here
	# TODO: createOrMakeExecutableFolders() call goes here
	echo -e "${Purple}setupGitAndConfigs()${NC}"
	setupGitAndConfigs
	echo -e "${Purple}createOrMakeExecutableFolders()${NC}"
	createOrMakeExecutableFolders

	sectionBreak
fi

# ------ Terminal utilities for any system, mostly graphics agnostic -- #

if [[ $options = *'t'* ]]; then
	echo -e "${Purple}Installing terminal utilities.${NC}"

	terminalUtils=('zsh' 'tmux' 'vim' 'fastfetch' 'fzf' 'btop' 'keepassxc' 'redshift' 'feh' 'cmatrix' 'python3')
	installWithPackageManager "${terminalUtils[@]}"

	# os, pls don't override my shell stuff
	sudo rm /etc/profile

	# make zsh default so restarting the shell gets us closer
	sudo chsh -s $(which zsh) $USER

	# oh-my-zsh and syntax highlighting
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	zshHighlightingPack=('zsh-syntax-highlighting')
	installWithPackageManager "${zshHighlightingPack[@]}"

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
	# TODO: include gnome-disks/gnome-disk-utility (arch/debian)
	largeGraphicalUtils=('gimp' 'krita' 'inkscape' 'darktable' 'ardour' 'blender' 'xf86-input-wacom' 'picom' 'thunar' 'fragments')
	installWithPackageManager "${largeGraphicalUtils[@]}"

	PS3="Select a browser to install: "
	select browser in chromium firefox-developer-edition brave-browser none; do
		case $browser in
			chromium)
			eval "$distroInstallPhrase chromium"
			break
			;;
			firefox-developer-edition)
			eval "$distroInstallPhrase firefox-developer-edition"
			break
			;;
			brave-browser)
			eval "$distroInstallPhrase brave-browser"
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

if [[ $options = *'d'* ]]; then
	extraPrograms=('powerline-fonts' 'code' 'qimgv')
	installWithPackageManager "${extraPrograms[@]}"
	
	sectionBreak
fi



# ------ to install awesome wm programs to go with configs -- #

if [[ $options = *'w'* ]]; then
	echo -e "${Purple}Installing AwesomeWM utilities.${NC}"
	awesomewmUtils=('awesome' 'rofi' 'arandr')
	installWithPackageManager "${awesomewmUtils[@]}"

	sectionBreak
fi
