#!/bin/bash

# Note: you will be prompted to enter the password several times through the script
# run with . genconfig_image.sh
# please note this script is fragile, as public download urls may change

# load latest version numbers of software
. versions.sh

cd ~

sudo emerge eix    # more efficient and flexible than emerge's search
sudo emerge layman # used to setup overlays

sudo layman -S && sudo eix-sync
sudo emerge -uDNa @world

# http://gentoo.linuxhowtos.org/faq/cleandistfiles.htm
# /usr/portage/distfiles
# /var/tmp/portage
sudo emerge gentoolkit # tools to ease administration of a system

sudo emerge app-text/tree
sudo emerge net-misc/ipcalc
sudo emerge x11-misc/xclip
# sudo emerge keepassx

sudo emerge dev-vcs/git

if [[ ! -d /etc/portage/package.keywords/ ]]; then
  mkdir /etc/portage/package.keywords/
fi

# install tig (https://github.com/jonas/tig)
echo "=dev-vcs/tig-${latest_tig_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
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

echo "=www-client/phantomjs-${latest_phantomjs_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge phantomjs

# install jslint
curl -LO http://www.javascriptlint.com/download/jsl-${latest_jsl_version}-src.tar.gz
tar xzvf jsl-${latest_jsl_version}-src.tar.gz
cd jsl-${latest_jsl_version}/src/
make -f Makefile.ref
cd ~
sudo cp jsl-${latest_jsl_version}/src/Linux_All_DBG.OBJ/jsl /usr/local/bin
sudo rm jsl-${latest_jsl_version}-src.tar.gz
sudo rm -rf ~/jsl-${latest_jsl_version}

sudo emerge zsh
# sudo emerge app-shells/zsh-completion
# echo "autoload -U compinit promptinit" >> ~/.zshrc
# echo "compinit" >> ~/.zshrc
# echo "promptinit; prompt gentoo" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh

echo "=dev-java/oracle-jdk-bin-1.8.0.20 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
wget http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz
sudo mv jdk-8u20-linux-x64.tar.gz /var/calculate/remote/distfiles
sudo emerge dev-java/oracle-jdk-bin

# install Maven (http://maven.apache.org/download.cgi)
# echo "=dev-java/maven-bin-3.1.1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
# sudo emerge dev-java/maven-bin
wget http://ftp.byfly.by/pub/apache.org/maven/maven-3/${latest_mvn_version}/binaries/apache-maven-${latest_mvn_version}-bin.zip
sudo unzip apache-maven-${latest_mvn_version}-bin.zip -d /usr/local/apache-maven # the subdirectory apache-maven-3.1.1 will be created from the archive.
rm apache-maven-${latest_mvn_version}-bin.zip
mvn -v
# http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

# TODO: install Eclipse

# TODO: install Tomcat

# TODO: install JBoss AS

\curl -sSL https://get.rvm.io | bash -s -- --version latest
source ~/.rvm/scripts/rvm
gem install bundler # still unknown command

# setup Bundler
# TODO: replace the hardcoded number of cpu cores with the proper command
bundle config --global jobs 3
# Nokogiri builds and uses a packaged version of libxslt. Use the system library instead
bundle config build.nokogiri --use-system-libraries

# install Ruby via RVM
rvm install 1.9.3,2.0.0,2.1.5,$latest_ruby_version,rbx,jruby # java is needed for jruby to run
# rvm reinstall ruby-2.1.5 --with-tcl --with-tk
rvm use $latest_ruby_version --default
rvm docs generate-ri
gem install rails -v $latest_rails_version

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

# install ag utility
sudo emerge the_silver_searcher

# install vim (http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/)
echo "=app-editors/vim-core-${latest_vim_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
echo "=app-editors/vim-${latest_vim_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
echo "=app-editors/gvim-${latest_vim_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo USE="python" emerge app-editors/vim
sudo USE="python" emerge app-editors/gvim
git clone git@ssh.github.com:dskecse/dotvim.git ~/.vim
cd $_
rake setup
# http://cx4a.org/software/rsense/
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
# ln -s ~/.dotfiles/emacs/emacs ~/.emacs

sudo EXTRA_ECONF="--with-png --with-jpeg" emerge imagemagick

# setup python environment
wget -qO - https://bootstrap.pypa.io/get-pip.py | sudo python
sudo pip install WebOb
sudo pip install Paste
sudo pip install webapp2
sudo pip install appengine
# Install requires a virtual environment to be active

# install R (http://cran.rstudio.com/)
echo "=dev-lang/R-${latest_r_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge dev-lang/R
# install RStudio with R v2.11.1+ (http://www.rstudio.com/ide/download/desktop)
echo "=sci-mathematics/rstudio-${latest_rstudio_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge sci-mathematics/rstudio

# TODO: install Go

# install Erlang OTP (https://www.erlang-solutions.com/downloads/download-erlang-otp)
# Java as a dependency
echo "=dev-lang/erlang-${latest_erlang_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge erlang
# Erlang/OTP Platform is a complex system composed of many smaller applications (modules).
# Installing the erlang package automatically installs the entire OTP suite.
# run using `erl`

# install Elixir
echo "=dev-lang/elixir-${latest_elixir_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge elixir

sudo layman -a haskell
echo "=dev-haskell/haskell-platform-${latest_haskell_version} ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge haskell-platform --autounmerge-mask && sudo dispatch-conf u
sudo emerge haskell-platform
cabal update
cabal install aeson haskell-src-exts haddock
cabal install ghc-mod # for import and LANGUAGE completions and type inference

wget -qO- http://download.redis.io/releases/redis-${latest_redis_version}.tar.gz | tar xzf -
sudo mv redis-${latest_redis_version} /opt/redis && cd $_
sudo make install
cd utils
sudo ./install_server.sh
sudo /etc/init.d/redis_6379 restart
sudo rc-update add redis_6379 default
cd ~

# http://wiki.gentoo.org/wiki/MySQL/Startup_Guide
sudo emerge mysql # installs 9 packages
sudo emerge --config "=dev-db/mysql-${latest_mysql_version}"
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

wget http://chromedriver.storage.googleapis.com/${latest_chromedriver_version}/chromedriver_linux64.zip
sudo unzip chromedriver_linux64.zip -d /usr/local/bin
sudo chmod 755 $_/chromedriver
rm chromedriver_linux64.zip

# TODO: install Charles proxy

# install ngrok reverse proxy
wget https://dl.ngrok.com/linux_386/ngrok.zip
unzip ngrok.zip && rm ngrok.zip
./ngrok -help
# inspect and replay requests at localhost:4040

sudo emerge mplayer2

# dropbox + dropbox-cli
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-as-a-service-onto-ubuntudebian-servers
sudo emerge net-misc/dropbox
sudo emerge net-misc/dropbox-cli
dropbox-cli autostart y
dropbox-cli start

sudo emerge unetbootin

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

# install Rust (nightly build)
# This also installs Cargo, Rust's package manager
if ! command -v rustc >/dev/null; then
  curl -s https://static.rust-lang.org/rustup.sh | sudo sh
  rustc -v
fi

# TODO: install Tk

# TODO: install LaTeX

# TODO: install Virtualbox

# sudo apt-get install -y gnupg # or gpg

sudo emerge screenfetch

# install cups and Samsung printer driver
sudo emerge splix

wget http://download.jetbrains.com/cpp/clion-138.1965.18.tar.gz
tar xzvf clion-138.1965.18.tar.gz
sudo mv clion-138.1965.18/ /opt/clion
cd /opt/clion/bin
# install java prior to running the next command
sudo ./clion.sh

sudo emerge thunderbird-bin

sudo emerge x11-base/xorg-x11
sudo emerge xmonad xmonad-contrib xmobar dmenu --autounmask-write
sudo dispatch-conf u
sudo emerge xmonad xmonad-contrib xmobar dmenu
xmonad --recompile
startx
