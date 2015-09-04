#!/usr/bin/env bash

rc_files=(
  gemrc
  github_token
  gitignore_global
  gitconfig
  iex.exs
  irbrc
  railsrc
  zshrc
)

ln -fs "$HOME/.dotfiles/bin" "$HOME/bin"

[ ! -f "$HOME/.dotfiles/github_token" ] && cp ~/.dotfiles/github_token.example ~/.dotfiles/github_token

ln -fs "$HOME/.dotfiles/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# shellcheck disable=SC2128
for file in $rc_files; do
  # TODO: supress warnings in cases files exist
  ln -s "$HOME/.dotfiles/$file" "$HOME/.$file"
done

exec /bin/zsh
