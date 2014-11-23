## Setup

    git clone git@ssh.github.com:dskecse/dotfiles.git ~/.dotfiles
    ./bootstrap.sh

## Mac OS X

Use [thoughtbot's laptop script](https://github.com/thoughtbot/laptop) to set up
an OS X development environment:

    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log

Add a symlink to `laptop.local` before running the above mentioned script to
install custom packages:

    ln -s ~/.dotfiles/laptop.local ~/.laptop.local
