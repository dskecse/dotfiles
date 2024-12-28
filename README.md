[![build](https://github.com/dskecse/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/dskecse/dotfiles/actions/workflows/main.yml)

## Setup

    git clone https://github.com/dskecse/dotfiles ~/.dotfiles
    cd $_
    [ ! -f github_token ] && cp github_token.example github_token
    ln -fs gpg-agent.conf ~/.gnupg/gpg-agent.conf
    ln -fs bundle/config ~/.bundle/config
    brew tap thoughtbot/formulae
    brew install rcm
    env RCRC=$HOME/.dotfiles/rcrc rcup

## Benchmarking

To figure out how fast a new tab opens in a terminal run:

    repeat 3 { /usr/bin/time zsh -i -c exit }

The last time it was run the stats were:

    1.04 real         0.64 user         0.36 sys
    1.04 real         0.64 user         0.36 sys
    1.03 real         0.63 user         0.36 sys

To find out what happens during that time run:

    /bin/zsh -i -x

## TODO

- [x] Add [Apple Silicon support](https://github.com/dskecse/laptop/commit/cde627d12c70e2fc0ab26f85ba86d8d716889232)
- [ ] Run benchmarks via Github Actions

## Inspiration

https://github.com/lest/dotfiles
