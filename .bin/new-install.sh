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

# pls set dis correctly
explicitUser='walter'
explicitHomeFolder='/home/walter'

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
	rmdir $explicitHomeFolder/Pictures
	rmdir $explicitHomeFolder/Videos
	rmdir $explicitHomeFolder/Public
	rmdir $explicitHomeFolder/Templates
	rmdir $explicitHomeFolder/Music
	rmdir $explicitHomeFolder/snap

	mkdir $explicitHomeFolder/Documents
	mkdir $explicitHomeFolder/Documents/Media
	mkdir $explicitHomeFolder/Documents/Media/Audio
	mkdir $explicitHomeFolder/Documents/Media/Videos
	mkdir $explicitHomeFolder/Documents/Media/Images
	mkdir $explicitHomeFolder/Documents/Media/Models
	mkdir $explicitHomeFolder/git
	mkdir $explicitHomeFolder/non-pac
	mkdir $explicitHomeFolder/non-pac/imgapp
	mkdir $explicitHomeFolder/non-pac/AUR

	# sometimes sudo makes root the owner of all these damn folders
	# I need to be able to change them obviously!
	sudo chown -R $explicitHomeFolder *

	# this all will only work if the git pull down worked
	sudo chmod +x -R $explicitHomeFolder/.bin
}

function setupGitAndConfigs {
	echo -e "${Purple}Downloading initial configs.${NC}"

	# from git instructions
	echo ".cfg" >> $explicitHomeFolder/.gitignore
	git clone --bare https://github.com/wtraceyv/dotfiles.git $explicitHomeFolder/.cfg
	git --git-dir=$explicitHomeFolder/.cfg/ --work-tree=$explicitHomeFolder config --local status.showUntrackedFiles no
	git --git-dir=$explicitHomeFolder/.cfg/ --work-tree=$explicitHomeFolder checkout manjaro

	echo "If you get errors about file conflicts, delete the local files causing the conflict."
	echo -e "Then rerun the command ${Green}config checkout manjaro${NC} or applicable branch."
	echo -e "If you're not a sudoer, then: ${Green}su -${NC}, then ${Green}usermod -a -G sudo <username>${NC}"

	echo -e "${Purple}Cloning other git repos..${NC}"

	mkdir $explicitHomeFolder/pass
	git clone https://github.com/wtraceyv/pass.git ~/pass

	mkdir $explicitHomeFolder/Documents/Vault
	git clone https://github.com/wtraceyv/obsidian-vault.git ~/Documents/Vault

}

function installWithPackageManager {
	packages=("$@")
	for i in "${packages[@]}"
	do
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
				eval "git clone https://aur.archlinux.org/$i.git $explicitHomeFolder/non-pac/AUR"
				eval "makepkg -si $explicitHomeFolder/non-pac/AUR/$i"
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
	echo "$token" >> $explicitHomeFolder/git/aa-git-token

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


	installWithPackageManager "${terminalUtils[@]}"

	# os, pls don't override my shell stuff
	sudo rm /etc/profile

	# make zsh default so restarting the shell gets us closer
	sudo chsh -s $(which zsh) $explicitUser

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
	largeGraphicalUtils=('gimp' 'krita' 'inkscape' 'darktable' 'ardour' 'blender' 'xf86-input-wacom' 'fragments')
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
	echo -e "If you need them, fetch below image apps online and place at ${Cyan}$explicitHomeFolder/non-pac/imgapp${NC}"
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
			AURprograms=('powerline-fonts-git' 'nerd-fonts-arimo' 'visual-studio-code-bin' 'qimgv')
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
	awesomewmUtils=('awesome' 'rofi' 'picom' 'thunar' 'arandr')
	installWithPackageManager "${awesomewmUtils[@]}"

	sectionBreak
fi
