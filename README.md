```
git clone git@ssh.github.com:dskecse/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/iex.exs ~/.iex.exs
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/emacs/emacs ~/.emacs
mkdir ~/.xmonad && ln -s ~/.dotfiles/xmonad.hs $_
exec /bin/zsh
```
