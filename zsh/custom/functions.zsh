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
