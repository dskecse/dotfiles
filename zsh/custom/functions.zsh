# Remove a particular Ruby version
rbrm() {
  if [[ -z "$1" ]]; then
    echo "Usage: rbrm [ruby-version]"
    return 1
  fi

  local ruby_dir_to_rm="$HOME/.rubies/ruby-$1"
  if [[ -d "$ruby_dir_to_rm" ]]; then
    echo "Removing '$ruby_dir_to_rm'..."
    rm -rf "$ruby_dir_to_rm"
  fi
  local another_ruby_dir_to_rm="$HOME/.gem/$1" # may not be present
  if [[ -d "$another_ruby_dir_to_rm" ]]; then
    echo "Removing '$another_ruby_dir_to_rm'..."
    rm -rf "$another_ruby_dir_to_rm"
  fi
}

# Upgrade Ruby to the latest version
rbup() {
  ruby-install --update

  local latest_ruby_version
  latest_ruby_version=$(tail -1 "$HOME/.cache/ruby-install/ruby/stable.txt")
  if chruby | grep -Fq "$latest_ruby_version"; then
    echo "Ruby $latest_ruby_version already installed, aborting..."
    return
  fi

  echo "Installing Ruby $latest_ruby_version..."
  ruby-install --no-reinstall \
    --src-dir "$HOME/.cache/ruby-install" \
    --install-dir "$HOME/.rubies/ruby-$latest_ruby_version" \
    --cleanup \
    ruby "$latest_ruby_version" -- \
    "--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl" \
    "--with-opt-dir=$HOMEBREW_PREFIX/opt/readline:$HOMEBREW_PREFIX/opt/libyaml:$HOMEBREW_PREFIX/opt/gdbm:$HOMEBREW_PREFIX/opt/jemalloc" \
    "--with-jemalloc"

  echo "Setting the default Ruby version to $latest_ruby_version..."
  echo "$latest_ruby_version" > "$HOME/.ruby-version"

  # Mimic shell restart
  export RUBY_VERSION="$latest_ruby_version"
  # export RUBYOPT=
  export RUBY_ENGINE=ruby
  export RUBY_ROOT="$HOME/.rubies/ruby-$latest_ruby_version"
  export PATH="$RUBY_ROOT/bin:$PATH"
  export GEM_HOME="$HOME/.gem/$RUBY_ENGINE/$RUBY_VERSION"
  export GEM_ROOT="$RUBY_ROOT/lib/ruby/gems/$RUBY_VERSION"
  export GEM_PATH="$GEM_HOME:$GEM_ROOT"
  export PATH="$GEM_HOME/bin:$GEM_ROOT/bin:$PATH"

  echo "Updating RubyGems ..."
  gem update --system
  echo "Installing Bundler ..."
  gem install bundler
}
