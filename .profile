# another place to put PATH adds
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.bin/util
export PATH=$PATH:$HOME/.bin/fun

export EDITOR=/usr/bin/vim
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# fancy input stuff
export GTK_IM_MODULE='ibus'
export QT_IM_MODULE='ibus'
export XMODIFIERS=@im='ibus'

ibus-daemon -drx
