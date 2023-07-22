#! /bin/bash
#

ZSH_SYNTAX_REPO="https://github.com/zsh-users/zsh-syntax-highlighting.git"
ZSH_SUGGEST_REPO="https://github.com/zsh-users/zsh-autosuggestions"
ZSH_BASE_REPO="https://github.com/chriskempson/base16-shell.git"


setup_zsh() {
	ZSH_PATH=`which zsh`
	mkdir -p ~/.cache/zsh

	git clone ${ZSH_SUGGEST_REPO} ~/.zsh/zsh-autosuggestions
	git clone ${ZSH_SYNTAX_REPO} ~/.zsh/zsh-syntax-highlighting 
	git clone ${ZSH_BASE_REPO} ~/.config/base16-shell

	chsh -s ${ZSH_PATH} || sudo usermod --shell ${ZSH_PATH} ${CURRENT_USER} || echo "Setting zsh as default shell failed, do it yourself kiddo"
}

ask "setup zsh? (y/n)"
[ "$RESP" != "n" ] && setup_zsh
