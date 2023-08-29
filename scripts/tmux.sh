#! /bin/bash
#
#

configure_tmux() {
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  bash "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
}

ask "configure tmux? (y/n)"
[ "$RESP" != "n" ] && configure_tmux
