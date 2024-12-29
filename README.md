[![build](https://github.com/dskecse/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/dskecse/dotfiles/actions/workflows/main.yml)

## Setup

```sh
git clone https://github.com/dskecse/dotfiles ~/.dotfiles
cd $_
[ ! -f github_token ] && cp github_token.example github_token
ln -fs gpg-agent.conf ~/.gnupg/gpg-agent.conf
ln -fs bundle/config ~/.bundle/config
brew tap thoughtbot/formulae
brew install rcm
env RCRC=$HOME/.dotfiles/rcrc rcup
```

## Benchmarking

To figure out how fast a new tab opens in a terminal,
first make sure to gather the shell arguments in a terminal tab currently open:

```sh
> echo "$-"
569JNRXZghiklms
```

In this case e.g. `i` indicates whether the shell is "interactive",
and `l` whether the shell is a "login" one (see the output of `zsh --help` for more info).

NOTE: Another way to check whether the shell is interactive/non-interactive or login/non-login:

```sh
[[ -o interactive ]] && echo "interactive" || echo "non-interactive"
[[ -o login ]] && echo "login" || echo "non-Login"
```

Then run the following command with the options above or at least `il` (if they are present):

```sh
repeat 3 { /usr/bin/time zsh -il -c exit }
```

The last time it was run, the stats were:

    0.56 real         0.27 user         0.26 sys
    0.55 real         0.27 user         0.26 sys
    0.54 real         0.26 user         0.26 sys

To find out what happens during that time, run:

```sh
zsh -il -x
```

## TODO

- [x] Add [Apple Silicon support](https://github.com/dskecse/laptop/commit/cde627d12c70e2fc0ab26f85ba86d8d716889232)
- [ ] Run benchmarks via Github Actions

## Inspiration

https://github.com/lest/dotfiles
