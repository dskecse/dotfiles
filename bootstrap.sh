#!/usr/bin/env bash

rc_files=(
  bowerrc
  gemrc
  git/github_token
  git/gitignore_global
  git/gitconfig
  iex.exs
  irbrc
  railsrc
  rvmrc
  tmux.conf
  zsh/zshrc
)

cp ~/.dotfiles/git/github_token.example ~/.dotfiles/git/github_token

# shellcheck disable=SC2128
for file in $rc_files; do
  # use greedy deletion from the beginning of a string
  ln -s "$HOME/.dotfiles/$file" "$HOME/.${file##*/}"
done

if [[ $OSTYPE == linux* ]]; then
  if [[ ! -d "$HOME/.xmonad" ]]; then
    ln -s "$HOME/.dotfiles/xmonad" "$HOME/.xmonad"
  fi
fi

exec /bin/zsh
