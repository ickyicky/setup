#! /bin/bash
#

cd $HOME
REPO_URL=git@github.com:ickyicky/dot.git
git clone --bare $REPO_URL $HOME/.dot/
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
dot config status.showUntrackedFiles no
dot restore .

mkdir -p Projects/{Personal,Work}
SETUP_REPO_URL=git@github.com:ickyicky/setup.git
git clone $SETUP_REPO_URL Projects/Personal/setup
cd Projects/Personal/setup
./setup.sh
