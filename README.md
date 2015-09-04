[![Build Status](https://travis-ci.org/dskecse/dotfiles.svg?branch=master)](https://travis-ci.org/dskecse/dotfiles)

## Setup

    git clone https://github.com/dskecse/dotfiles ~/.dotfiles
    cd $_
    ln -fs bin/ ~/bin
    [ ! -f github_token ] && cp github_token.example github_token
    ln -fs gpg-agent.conf ~/.gnupg/gpg-agent.conf
    brew tap thoughtbot/formulae
    brew install rcm
    env RCRC=$HOME/.dotfiles/rcrc rcup

## Inspiration

[Unofficial guide to dotfiles on Github](https://dotfiles.github.io/)
