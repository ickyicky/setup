#! /bin/bash
#

VIM_PLUG_INSTALL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

setup_vim() {
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${VIM_PLUG_INSTALL}
	vim +PlugInstall +qall
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	git clone git@github.com:ickyicky/astrovim_config.git ~/.config/nvim/lua/user
}

ask "setup vim? (y/n)"
[ "$RESP" != "n" ] && setup_vim
