#! /bin/bash
#

BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
FLAT_REMIX_GTK_LINK="https://github.com/daniruiz/flat-remix-gtk.git"
FLAT_REMIX_GNOME_LINK="https://github.com/daniruiz/flat-remix-gnome.git"


setup_gnome() {
	ask "install gnome themes? (y/n)"
	[ "$RESP" != "n" ] && [[ ! -z "$(which gnome-shell)" ]] && preconfigure_gnome
	ask "apply gnome themes and configure it? (y/n)"
	[ "$RESP" != "n" ] && [[ ! -z "$(which gnome-shell)" ]] && configure_gnome
	ask "configure fonts?(y/n)"
	[ "$RESP" != "n" ] && [[ ! -z "$(which gnome-shell)" ]] && configure_fonts
	ask "configure pop-shell?(y/n)"
	[ "$RESP" != "n" ] && [[ ! -z "$(which gnome-shell)" ]] && configure_pop_shell
}

install_gnome_themes() {
	git clone ${FLAT_REMIX_GTK_LINK} temp
	git clone ${FLAT_REMIX_GNOME_LINK} temp2
	cd temp
	sudo make install
	cd ..
	cd temp2
	sudo make install
	cd ..
	rm -rf temp temp2
}

preconfigure_gnome() {
	${PKGMAN} gnome-tweaks
	if [[ "$DISTRO" =~ ARCH*|MANJARO*|ENDEAVOUR* ]]; then
		AURS="
			flat-remix
			flat-remix-gnome
			flat-remix-gtk
			xcursor-breeze
			tela-circle-icon-theme-git 
		"
		yay -S --noconfirm ${AURS}
	elif [[ "$DISTRO" =~ UBUNTU* ]]; then
		sudo add-apt-repository ppa:daniruiz/flat-remix
		sudo apt update
		${PKGMAN} flat-remix-gnome flat-remix-gtk
		install_tela
	elif [[ "$DISTRO" =~ FEDORA*|CENTOS* ]]; then
		${PKGMAN} gnome-shell-theme-flat-remix flat-remix-gtk2-theme flat-remix-gtk3-theme
		install_tela
	else
		install_gnome_themes
		install_tela
	fi
}

configure_pop_shell() {
	yay -S --noconfirm gnome-shell-extension-pop-shell-git 2>/dev/null
	gsettings set org.gnome.shell.extensions.pop-shell focus-down "['<Super><Alt>j']"
	gsettings set org.gnome.shell.extensions.pop-shell focus-up "['<Super><Alt>k']"
	gsettings set org.gnome.shell.extensions.pop-shell focus-left "['<Super><Alt>h']"
	gsettings set org.gnome.shell.extensions.pop-shell focus-right "['<Super><Alt>l']"

	gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-down "['<Super><Shift><Primary>Down', '<Super><Shift><Primary>KP_Down']"
	gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-left "['<Super><Shift>Left', '<Super><Shift>KP_Left']"
	gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-right "['<Super><Shift>Right', '<Super><Shift>KP_Right']"
	gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-up "['<Super><Shift><Primary>Up', '<Super><Shift><Primary>KP_Up']"
	gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-down "['<Super><Shift>Down', '<Super><Shift>KP_Down']"
	gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-up "['<Super><Shift>Up', '<Super><Shift>KP_Up']"

	gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>i']"
}

configure_gnome() {
	gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-Blue-Dark-fullPanel"
	gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"
	gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-blue-dark"
	gsettings set org.gnome.desktop.interface cursor-theme "Breeze"
	cp -r /usr/share/themes/Flat-Remix-LibAdwaita-Blue-Dark/* ~/.config/gtk-4.0/
	gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super>c']"

	# Settings for vertical:
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Up']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Down']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<super><shift>Up']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<super><shift>Down']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>k']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>j']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<super><shift>k']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<super><shift>j']"

	gsettings set org.gnome.desktop.wm.keybindings close "['<Ctrl>q']"
	gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super><Ctrl>h']"
	gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super><Ctrl>l']"
	gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>m']"
	gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>v']"
	gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>Down', '<Super><Ctrl>j']"
	gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up', '<Super><Ctrl>k']"


	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
	"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/']"

	$BEGINNING/custom0/ name "Run terminal"
	$BEGINNING/custom0/ command "kitty -o \"linux_display_server=x11\""
	$BEGINNING/custom0/ binding "<Super>Return"

	$BEGINNING/custom1/ name "Run chromium"
	$BEGINNING/custom1/ command "chromium"
	$BEGINNING/custom1/ binding "<Super>n"

	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

	[ "$(gsettings get org.gnome.shell enabled-extensions)" = "@as []" ] && gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com']"


	mkdir -p ~/.local/share/background
	curl https://i.imgur.com/YtakXJ2.jpg --output ~/.local/share/background/wallpaper.jpg
	gsettings set org.gnome.desktop.background picture-uri "file://${HOME}/.local/share/background/wallpaper.jpg"
}

configure_fonts() {
	gsettings set org.gnome.desktop.interface monospace-font-name "Comic Mono 10"
	gsettings set org.gnome.desktop.interface font-name "Comic Sans MS 11"
	gsettings set org.gnome.desktop.wm.preferences titlebar-font "Comic Sans MS Bold 11"
}

install_tela() {
	git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git tela
	cd tela
	chmod +x install.sh
	./install.sh -a
	cd ..
	rm -rf tela
}

[[ ! -z "$(which gnome-shell)" ]] && setup_gnome
