#!/bin/bash
# Note: you will be prompted to enter the password several times through the script
# run with . genconfig_image.sh
# please note this script is fragile, as public download urls may change

cd ~

sudo cl-update
sudo layman -S && sudo eix-sync
sudo emerge -uDNa world

# Clean up Calculate distro
sudo emerge -C clementine
sudo emerge -C media-video/smplayer
sudo emerge -C media-gfx/gimp
# Use `emerge @preserved-rebuild` to rebuild packages using these libraries
sudo emerge -C gtkam
sudo emerge -C xsane
sudo emerge -C filezilla
sudo emerge -C chromium chromium-adblock
sudo emerge -C liferea
sudo emerge -C libreoffice libreoffice-l10n

# install some basic utilities
sudo emerge dos2unix
sudo emerge app-text/tree
sudo emerge net-misc/ipcalc
sudo emerge x11-misc/xclip
# sudo emerge keepassx

sudo emerge dev-vcs/git
git config --global user.name "Dzianis Dashkevich"
git config --global user.email "dskecse@gmail.com"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global push.default simple
git config --global color.ui true
git config --global core.autocrlf input
git config --global core.excludesfile ~/.gitignore_global

# install tig (https://github.com/jonas/tig)
# http://jonas.nitro.dk/tig/
# http://jonas.nitro.dk/tig/INSTALL.html
# depends on git, ncurses (ncursesw - ncurses w/ wide character support
echo "=dev-vcs/tig-2.0.3 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge dev-vcs/tig

sudo emerge tmux

sudo emerge nodejs
npm -v
node -v
# install Bower package manager (http://blog.teamtreehouse.com/getting-started-bower)
sudo npm install -g bower
sudo npm install -g coffee-script
# install Grunt js task runner (http://blog.teamtreehouse.com/getting-started-with-grunt)
sudo npm install -g grunt-cli  # /usr/bin/grunt -> /usr/lib/node_modules/grunt-cli/bin/grunt

echo "=www-client/phantomjs-1.9.7 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge phantomjs

# install jslint
curl -LO http://www.javascriptlint.com/download/jsl-0.3.0-src.tar.gz
tar xzvf jsl-0.3.0-src.tar.gz
cd jsl-0.3.0/src/
make -f Makefile.ref
cd ~
sudo cp jsl-0.3.0/src/Linux_All_DBG.OBJ/jsl /usr/local/bin
sudo rm jsl-0.3.0-src.tar.gz
sudo rm -rf ~/jsl-0.3.0

sudo emerge zsh
# sudo emerge app-shells/zsh-completion
# echo "autoload -U compinit promptinit" >> ~/.zshrc
# echo "compinit" >> ~/.zshrc
# echo "promptinit; prompt gentoo" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh # AUTOMATIC way
# git clone git@github.com:robbyrussel/oh-my-zsh.git ~/.oh-my-zsh # MANUAL way (use when you have ssh keys to authenticate with)
# cp ~/.zshrc ~/.zshrc.orig # OPTIONAL backup existing ~/.zshrc file
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc # create a new zsh config by copying zsh template
# exec /bin/zsh

echo "=dev-java/oracle-jdk-bin-1.8.0.20 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
wget http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz
sudo mv jdk-8u20-linux-x64.tar.gz /var/calculate/remote/distfiles
sudo emerge dev-java/oracle-jdk-bin

# install Maven (http://maven.apache.org/download.cgi)
# echo "=dev-java/maven-bin-3.1.1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
# sudo emerge dev-java/maven-bin
wget http://ftp.byfly.by/pub/apache.org/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.zip
sudo unzip apache-maven-3.1.1-bin.zip -d /usr/local/apache-maven # the subdirectory apache-maven-3.1.1 will be created from the archive.
rm apache-maven-3.1.1-bin.zip
mvn -v
# http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

# TODO: install Eclipse

# TODO: install Tomcat

# TODO: install JBoss AS

\curl -sSL https://get.rvm.io | bash -s -- --version latest
# enable auto-update
echo 'rvm_autoupdate_flag=2' >> ~/.rvmrc
echo 'export rvm_pretty_print=1' >> ~/.rvmrc
source ~/.rvm/scripts/rvm
unset RUBYOPT
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler # still unknown command

# setup Bundler
bundle config --global jobs 3
# Nokogiri builds and uses a packaged version of libxslt. Use the system library instead
bundle config build.nokogiri --use-system-libraries

# install Ruby via RVM
rvm install 1.9.3,2.0.0,2.1.3,rbx,jruby # java is needed for jruby to run
# rvm reinstall ruby-2.1.3 --with-tcl --with-tk
rvm use 2.1.3 --default
rvm docs generate-ri
gem install rails -v 4.1.6

# install Shoes4 (requires JDK and JRuby installed)
git clone git@github.com:shoes/shoes4.git
cd shoes4
bundle install
cd ~

# install heroku toolbelt
# this will install heroku cli, foreman, git
wget -qO - https://toolbelt.heroku.com/install.sh | sh

# install wkhtmltopdf (http://wkhtmltopdf.org/)
# Simple shell utility to convert html to pdf using the webkit rendering engine, and qt (dev-qt/webkit).
echo "=media-gfx/wkhtmltopdf-0.11.0_rc1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge media-gfx/wkhtmltopdf

# http://michael.orlitzky.com/articles/upgrading_postgresql-9.x_on_gentoo.php
# http://wiki.gentoo.org/wiki/PostgreSQL/QuickStart !!!
sudo emerge dev-db/postgresql-base dev-db/postgresql-server
sudo emerge --config dev-db/postgresql-server
# First, edit /etc/postgresql-NEW/pg_hba.conf and change the `local all all trust` line
# to `local all all password` for the localhost connections.
sudo /etc/init.d/postgresql-9.3 start

# TODO: install Sphinx

# install sublime text 3 (build 3065)
wget -qO- http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2 | tar xjvf -
sudo mv sublime_text_3 /opt/ # previously /usr/lib/
sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
sudo ln -s ~/.dotfiles/sublime/subl.desktop /usr/share/applications/subl.desktop
# Open up the file associations list and replace all occurrences of gedit.desktop with subl.desktop.
# sudo sed -i 's/gedit\.desktop/subl\.desktop/g' /usr/share/applications/defaults.list

# install vim and rails.vim (http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/)
sudo emerge app-editors/vim
sudo emerge app-editors/gvim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
mkdir .vim && cd $_
# install pathogen.vim to manage 'runtimepath' with ease
# https://github.com/tpope/vim-pathogen
mkdir -p ~/.vim/{autoload,bundle}
curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
# install nerdtree tree explorer plugin
git clone --depth 1 git@github.com:scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
# rails support
wget http://www.vim.org/scripts/download_script.php?src_id=16429
mv download_script* rails.zip
unzip rails.zip
rm -rf rails.zip
# to allow :help rails, start up vim and type :helptags ~/.vim/doc
#
# https://github.com/vim-ruby/vim-ruby
# http://cx4a.org/software/rsense/
# https://github.com/elixir-lang/vim-elixir
cd ~

# install emacs and basic config/plugins (http://appsintheopen.com/articles/1-setting-up-emacs-for-rails-development/part/7-emacs-ruby-foo)
sudo emerge app-editors/emacs
wget -qO- https://github.com/downloads/magit/magit/magit-1.1.1.tar.gz | tar xzvf - # emacs mode for git
cd magit-1.1.1 && make
sudo make install
# require magit in .emacs
cd ~
# cannot open load file, magit
rm -rf magit-1.1.1/
# http://www.emacswiki.org/emacs/RubyMode
wget http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/misc/ruby-mode.el
wget http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/misc/ruby-electric.el
sudo mkdir -p /usr/share/emacs/includes
sudo mv ruby-mode.el ruby-electric.el $_
# http://cx4a.org/software/rsense/
# https://github.com/elixir-lang/emacs-elixir
ln -s ~/.dotfiles/emacs/emacs ~/.emacs

sudo EXTRA_ECONF="--with-png --with-jpeg" emerge imagemagick

# TODO: install Python

# install R (http://cran.rstudio.com/)
echo "=dev-lang/R-3.1.1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge dev-lang/R
# install RStudio with R v2.11.1+ (http://www.rstudio.com/ide/download/desktop)
echo "=sci-mathematics/rstudio-0.98.1028 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge sci-mathematics/rstudio

# TODO: install Go

# install Erlang OTP (https://www.erlang-solutions.com/downloads/download-erlang-otp)
# Java as a dependency
echo "=dev-lang/erlang-17.3 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge erlang
# Erlang/OTP Platform is a complex system composed of many smaller applications (modules).
# Installing the erlang package automatically installs the entire OTP suite.
# run using `erl`

# install Elixir (v1.0.0)
echo "=dev-lang/elixir-1.0.0 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge elixir

# install Haskell (ghc, cabal, ...)
# build my own haskell-platform ebuild
# echo "=dev-haskell/haskell-platform-2013.2.0.0-r2 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
# sudo layman -a haskell
echo "=dev-haskell/haskell-platform-2013.2.0.0 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge haskell-platform
cabal update # command not found: cabal
cabal install aeson haskell-src-exts haddock
# for import and LANGUAGE completions and type inference
cabal install ghc-mod

wget -qO- http://download.redis.io/releases/redis-2.8.14.tar.gz | tar xzf -
sudo mv redis-2.8.14 /opt/redis && cd $_
sudo make install
cd utils
sudo ./install_server.sh
sudo /etc/init.d/redis_6379 restart
sudo rc-update add redis_6379 default
cd ~

# http://wiki.gentoo.org/wiki/MySQL/Startup_Guide
sudo emerge mysql # installs 9 packages
sudo emerge --config "=dev-db/mysql-5.5_39"
sudo /etc/init.d/mysql start
sudo /usr/bin/mysql_secure_installation

# TODO: install MongoDB

# old release
echo "=app-misc/elasticsearch-1.0.1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge app-misc/elasticsearch
sudo cp /etc/elasticsearch/elasticsearch.in.sh.sample /etc/elasticsearch/elasticsearch.in.sh
sudo cp /etc/elasticsearch/elasticsearch.yml.sample /etc/elasticsearch/elasticsearch.yml
sudo cp /etc/elasticsearch/logging.yml.sample /etc/elasticsearch/logging.yml

sudo emerge memcached

# TODO: install samba server

# TODO: install nginx

echo "=www-client/google-chrome-37.0.2062.94_p1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge google-chrome

wget http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip
sudo unzip chromedriver_linux64.zip -d /usr/local/bin
sudo chmod 755 $_/chromedriver
rm chromedriver_linux64.zip

# TODO: install Charles proxy

sudo emerge mplayer2

# dropbox + dropbox-cli
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-as-a-service-onto-ubuntudebian-servers
sudo emerge net-misc/dropbox
sudo emerge net-misc/dropbox-cli
dropbox-cli autostart y
dropbox-cli start

# TODO: install unetbootin

# install Matlab
# http://rutracker.org/forum/viewtopic.php?t=4761942
cd ~/Downloads/Matlab801_MacUnix
./mount_matlab801
cd ~/Matlab801
sudo ./install
# http://askubuntu.com/questions/139352/how-do-i-make-a-matlab-launcher-for-unity
# https://help.ubuntu.com/community/MATLAB
# create Matlab Launcher
sudo cp Matlab.png /usr/local/MATLAB/R2013a/
cp Matlab.desktop ~/.local/share/applications/
cd ~
~/Downloads/Matlab801_MacUnix/unmount_matlab801

# TODO: install Rust

# TODO: install Tk

# TODO: install LaTeX

# TODO: install Virtualbox

# sudo apt-get install -y gnupg # or gpg

sudo emerge screenfetch

# TODO: install cups and Samsung printer driver

# Install DE theme
sudo emerge greybird

wget http://download.jetbrains.com/cpp/clion-138.1965.18.tar.gz
tar xzvf clion-138.1965.18.tar.gz
sudo mv clion-138.1965.18/ /opt/clion
cd /opt/clion/bin
# install java prior to running the next command
sudo ./clion.sh

# http://forums.gentoo.org/viewtopic-t-921722-start-0.html
sudo layman -a lcd-filtering

echo "media-libs/fontconfig ~amd64" | sudo tee -a /etc/portage/package.keywords/fonts
echo "media-libs/freetype ~amd64" | sudo tee -a /etc/portage/package.keywords/fonts
echo "x11-libs/cairo ~amd64" | sudo tee -a /etc/portage/package.keywords/fonts
echo "x11-libs/libXft ~amd64" | sudo tee -a /etc/portage/package.keywords/fonts
echo "media-fonts/ubuntu-font-family ~amd64" | sudo tee -a /etc/portage/package.keywords/fonts

sudo emerge -uNa fontconfig freetype cairo libXft ubuntu-font-family

sudo emerge thunderbird

# install Xmonad wm (and possibly Xmobar) and extensions
sudo emerge xmonad-contrib
echo "=x11-misc/xmobar-0.21 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
echo "=dev-haskell/alsa-mixer-0.2.0.2 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
echo "=dev-haskell/alsa-core-0.5.0.1-r2 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge x11-misc/xmobar
xmonad --recompile && xmonad --replace
