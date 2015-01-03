#!/bin/bash

declare -a rc_files
rc_files=(
  git/github_token
  git/gitignore_global
  git/gitconfig
  iex.exs
  tmux.conf
  rvmrc
  gemrc
  zsh/zshrc
)

cp ~/.dotfiles/git/github_token.example ~/.dotfiles/git/github_token

for file in $rc_files; do
  # use greedy deletion from the beginning of a string
  ln -s "$HOME/.dotfiles/$file" "$HOME/.${file##*/}"
done

if [[ $OSTYPE == linux* ]]; then
  if [[ ! -d "$HOME/.xmonad" ]]; then
    mkdir ~/.xmonad && ln -s ~/.dotfiles/xmonad.hs $_
  fi
fi

exec /bin/zsh
