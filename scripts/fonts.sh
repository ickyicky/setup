#! /bin/bash
#

install_fonts() {
	if [[ "$UNAME" == "Darwin" ]]; then
		cp -r fonts/* ~/Library/Fonts/
	else
		mkdir -p ~/.local/share/fonts/
		cp -r fonts/* ~/.local/share/fonts/
	fi
}

ask "install fonts? (y/n)"
[ "$RESP" != "n" ] && install_fonts
