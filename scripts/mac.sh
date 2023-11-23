#! /bin/bash
#


setup_macos() {
	ask "install macos casks? (y/n)"
	[ "$RESP" != "n" ] && install_macos_casks
	ask "configure macos? (y/n)"
	[ "$RESP" != "n" ] && configure_macos
}


install_macos_casks() {
	brew install --cask nextcloud discord messenger openvpn-connect docker maccy geekbench sanesidebuttons amethyst scroll-reverser aldente betterdisplay hiddenbar maccy sanesidebuttons scroll-reverser
	brew install --HEAD neovim
	brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
}


configure_macos() {
	defaults write com.apple.dock expose-animation-duration -float 0.1
	defaults write -g InitialKeyRepeat -int 12
	defaults write -g KeyRepeat -int 1
	defaults write com.apple.Dock autohide-delay -float 0; killall Dock
	defaults write -g com.apple.mouse.scaling -integer -1
}


[[ ! -z "$(which brew)" ]] && setup_macos
