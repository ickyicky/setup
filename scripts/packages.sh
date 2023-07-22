#! /bin/bash
#
#
EXA_LINK="https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip"


assure_has_yay() {
	if [[ "$DISTRO" =~ ARCH*|MANJARO*|ENDEAVOUR* ]] && [[ -z "$(which yay)" ]]; then
		sudo pacman -S --needed git base-devel
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		rm -rf yay
	fi
}


install_exa() {
	wget "$EXA_LINK"
	exa_zip="$(ls exa*)"
	mkdir -p exa
	mv $exa_zip exa/
	cd exa
	unzip $exa_zip
	sudo mv bin/exa /usr/local/bin/
	cd ..
	rm -rf exa
}


packages() {
	PACKAGES="
		python3
		git
		zsh
		cmake
		neofetch
		htop
		xclip
		patch
		vifm
		nodejs
		npm
		tmux
	"
	PIP_PACKAGES="
		black
		ipython
	"

	if [[ "$DISTRO" == "MAC" ]]; then
		PACKAGES="
			wget
			exa
			neofetch
			nvim
			fzf
			python3
			gotop
			node
			tmux
			iterm2
			ripgrep
		"
	elif [[ "$DISTRO" =~ ARCH*|MANJARO*|ENDEAVOUR* ]]; then
		PACKAGES="$PACKAGES
			procps-ng
			binutils
			neovim
			exa
			kitty
			python-pip
			gnome-shell-extensions
			chromium
		"
	else
		PACKAGES="$PACKAGES
			python3-pip
			vim
		"
		install_exa
	fi
}

install_packages() {
	${PKGMAN} ${PACKAGES}
	python3 -m pip install ${PIP_PACKAGES}
	assure_has_yay
}

packages
ask "install avalibe packages? (y/n)"
[ "$RESP" != "n" ] && install_packages
