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

## Mac OS X

Use [thoughtbot's laptop script](https://github.com/thoughtbot/laptop) to set up
an OS X development environment:

    bash <(curl -s https://raw.githubusercontent.com/thoughtbot/laptop/master/mac) 2>&1 | tee ~/laptop.log

Add a symlink to `laptop.local` to install custom packages:

    ln -s ~/.dotfiles/laptop.local ~/.laptop.local
