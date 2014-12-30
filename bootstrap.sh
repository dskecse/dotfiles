#!/bin/bash

RC_FILES="git/github_token
git/gitignore_global
iex.exs
tmux.conf
rvmrc
gemrc
zsh/zshrc"

cp ~/.dotfiles/git/github_token.example ~/.dotfiles/git/github_token

for file in $RC_FILES; do
  # use greedy deletion from the beginning of a string
  # TODO: inspect this as it doesn't work as expected
  ln -s "$HOME/.dotfiles/$file" "$HOME/.${file##*/}"
done

if [[ ! -d "$HOME/.xmonad" ]]; then
  mkdir ~/.xmonad && ln -s ~/.dotfiles/xmonad.hs $_
fi

exec /bin/zsh
