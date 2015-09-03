#!/usr/bin/env bash

rc_files=(
  gemrc
  git/gitignore_global
  git/gitconfig
  iex.exs
  irbrc
  railsrc
  rvmrc
  tmux.conf
  zsh/zshrc
)

ln -fs "$HOME/.dotfiles/bin" "$HOME/bin"

# shellcheck disable=SC2128
for file in $rc_files; do
  # use greedy deletion from the beginning of a string
  ln -s "$HOME/.dotfiles/$file" "$HOME/.${file##*/}"
done

if [[ ! -d "$HOME/.xmonad" ]]; then
  ln -s "$HOME/.dotfiles/xmonad" "$HOME/.xmonad"
fi

exec /bin/zsh
