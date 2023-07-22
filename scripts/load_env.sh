#! /bin/bash
#

BREW_SCRIPT_LINK="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

ask() {
	echo "$@"
	read RESP
}


pkgman() {
	UNAME="$(uname -s)"
	if [[ "$UNAME" == "Darwin" ]]; then
		brew --help || /bin/bash -c "$(curl -fsSL ${BREW_SCRIPT_LINK})"
		PKGMAN="brew install"
		DISTRO="MAC"
		export PATH="$HOME/.local/bin:$HOME/.bin:$PATH:/opt/homebrew/bin:/Users/doman/Library/Python/3.9/bin"
	else
		DISTRO=`lsb_release -a | awk '/Description/ {print toupper($2)}'`
		case "$DISTRO" in
			ARCH*|MANJARO*|ENDEAVOUR*) PKGMAN="sudo pacman -S --noconfirm" ;;
			DEBIAN*|UBUNTU*|ELEMENTARY*) PKGMAN="sudo apt-get install -y" ;;
			FEDORA*|CENTOS*|RHEL*) PKGMAN="sudo yum install -y" ;;
			*) echo "${DISTRO} not recognized, specify package manager yourself:"; read PKGMAN
		esac
	fi
}


pkgman
