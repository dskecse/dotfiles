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

This will output the zsh init process xtrace output to stderr.
In order to redirect the output to a running log file instead, run:

```sh
exec 2>> trace.log
set -x
zsh -il -x
```

https://comp.unix.shell.narkive.com/B3NOS6f2/zsh-how-to-send-startup-scripts-xtrace-to-file

Benchmarks are now run on Github Actions using [hyperfine](https://github.com/sharkdp/hyperfine).
The following are [initial results](https://github.com/dskecse/dotfiles/actions/runs/12535587955/job/34957644878):

    Benchmark 1: zsh -il -c exit

      Time (mean ± σ):      19.1 ms ±   3.5 ms    [User: 5.1 ms, System: 13.7 ms]
      Range (min … max):    18.2 ms …  46.0 ms    65 runs
      Warning: The first benchmarking run for this command was significantly slower than the rest (46.0 ms). This could be caused by (filesystem) caches that were not filled until after the first run. You should consider using the '--warmup' option to fill those caches before the actual benchmark. Alternatively, use the '--prepare' option to clear the caches before each timing run.

## TODO

- [x] Add [Apple Silicon support](https://github.com/dskecse/laptop/commit/cde627d12c70e2fc0ab26f85ba86d8d716889232)
- [x] Run benchmarks via Github Actions
- [ ] Compare benchmarks between runs to avoid performance regressions

## Inspiration

https://github.com/lest/dotfiles
