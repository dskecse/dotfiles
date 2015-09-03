#!/usr/bin/env bash

rc_files=(
  gemrc
  git/github_token
  git/gitignore_global
  git/gitconfig
  iex.exs
  irbrc
  railsrc
  zsh/zshrc
)

ln -fs "$HOME/.dotfiles/bin" "$HOME/bin"
cp ~/.dotfiles/git/github_token.example ~/.dotfiles/git/github_token

ln -fs "$HOME/.dotfiles/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# shellcheck disable=SC2128
for file in $rc_files; do
  # use greedy deletion from the beginning of a string
  ln -s "$HOME/.dotfiles/$file" "$HOME/.${file##*/}"
done

exec /bin/zsh
