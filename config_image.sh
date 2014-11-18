#!/bin/bash

# Note: you will be prompted to enter the password several times through the script
# run with . config_image.sh
# please note this script is fragile, as public download urls may change

latest_ruby_version=2.1.5
latest_rails_version=4.1.8

cd ~

# delete standard games
sudo apt-get remove --purge gnome-mines gnome-sudoku gnome-mahjongg aisleriot -y

sudo apt-get update
# sudo apt-get upgrade -y

# install some basic programs
sudo apt-get install -y curl
sudo apt-get install -y dos2unix
sudo apt-get install -y mc
# sudo apt-get install -y zmv # for doing mass renaming
sudo apt-get install -y unrar
sudo apt-get install -y sqlite3 libsqlite3-dev # install sqlite3 dev
sudo apt-get install -y libssl-dev openssl zlib1g zlib1g-dev zlibc
sudo apt-get install -y libxslt-dev libxml2-dev
sudo apt-get install -y libcurl3-dev
sudo apt-get install -y g++
sudo apt-get install -y build-essential
# sudo apt-get install -y compizconfig-settings-manager # for Unity only
sudo apt-get install -y libreadline6-dev
sudo apt-get install -y links
sudo apt-get install -y graphviz
sudo apt-get install -y tree
sudo apt-get install -y lsb-release
sudo apt-get install -y traceroute
sudo apt-get install -y ipcalc
sudo apt-get install -y whois
sudo apt-get install -y nmap
# scriptreplay
# script
sudo apt-get install -y htop
sudo apt-get install -y xclip
sudo apt-get install -y keepassx

# install git
sudo apt-get install -y git gitg # git-core package is obsolete
git config --global user.name "Dzianis Dashkevich"
git config --global user.email "dskecse@gmail.com"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global push.default simple
git config --global color.ui true
git config --global core.autocrlf input
git config --global core.excludesfile ~/.gitignore_global

# install tig (https://github.com/jonas/tig) - already available via pkg manager
# http://jonas.nitro.dk/tig/
# http://jonas.nitro.dk/tig/INSTALL.html
# depends on git, ncurses (ncursesw - ncurses w/ wide character support
sudo apt-get install -y ncurses-base libncursesw5
# is required to properly handle utf-8 encoded strings) and possibly iconv
wget -qO- http://jonas.nitro.dk/tig/releases/tig-1.2.1.tar.gz | tar xzf -
cd tig-1.2.1/
make prefix=/usr/local
sudo make install prefix=/usr/local
cd ~ && rm -rf tig-1.2.1

# install tmux (http://tmux.sourceforge.net/)
# update-alternatives to use xterm instead of xterm-whatever
# ensure libevent is installed in the system
sudo apt-get install -y libevent-2.0.5
# http://tmux.svn.sourceforge.net/viewvc/tmux/trunk/FAQ
# http://zanshin.net/2013/09/05/my-tmux-configuration/
# http://www.sitepoint.com/tmux-a-simple-start/
sudo add-apt-repository ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y tmux
# http://ethanschoonover.com/solarized

# Install nodejs (possibly, through npm?) and npm
# http://developwithguru.com/how-to-install-node-js-and-npm-in-ubuntu-or-mint/
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs # this will install npm as well
# install Bower package manager (http://blog.teamtreehouse.com/getting-started-bower)
sudo npm install -g bower
sudo npm install -g coffee-script
# install Grunt js task runner (http://blog.teamtreehouse.com/getting-started-with-grunt)
sudo npm install -g grunt-cli  # /usr/bin/grunt -> /usr/lib/node_modules/grunt-cli/bin/grunt

# Install phantomjs
# Check the `universe` repository is enabled.
sudo apt-get install -y phantomjs

# Install jslint
curl -LO http://www.javascriptlint.com/download/jsl-0.3.0-src.tar.gz
tar xzvf jsl-0.3.0-src.tar.gz
cd jsl-0.3.0/src/
make -f Makefile.ref
cd ~
sudo cp jsl-0.3.0/src/Linux_All_DBG.OBJ/jsl /usr/local/bin
sudo rm jsl-0.3.0-src.tar.gz
sudo rm -rf ~/jsl-0.3.0

# install zsh
sudo apt-get install -y zsh
curl -L http://install.ohmyz.sh | sh # AUTOMATIC way
# git clone git@github.com:robbyrussel/oh-my-zsh.git ~/.oh-my-zsh # MANUAL way (use when you have ssh keys to authenticate with)
# cp ~/.zshrc ~/.zshrc.orig # OPTIONAL backup existing ~/.zshrc file
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc # create a new zsh config by copying zsh template
# exec /bin/zsh

# install Java (http://linuxg.net/how-to-install-oracle-java-jdk-678-on-ubuntu-13-04-12-10-12-04/)
sudo apt-get purge 'openjdk*' # remove OpenJDK first
sudo apt-get install software-properties-common # In order not to get issues with the add-apt-repository command
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y oracle-java8-set-default # automatically set up the Java 8 environment variables

# install Maven (http://maven.apache.org/download.cgi)
# http://askubuntu.com/questions/49557/how-do-i-install-maven-3?rq=1
wget http://ftp.byfly.by/pub/apache.org/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.zip
sudo unzip apache-maven-3.1.1-bin.zip -d /usr/local/apache-maven # the subdirectory apache-maven-3.1.1 will be created from the archive.
mvn -v
# http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html
# try `sudo apt-get install maven' # too many packages

# install Eclipse and Tomcat (and all the other stuff like JUnit, Ant etc.)
# http://gridlab.dimes.unical.it/lackovic/eclipse-tomcat-ubuntu-jersey/
# sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com DCC7AFE0
# sudo add-apt-repository ppa:eclipse-team/ppa # add --remove to remove ppa's
# sudo apt-get update
# or install Eclipse EE from sources
# wget -qO - http://www.eclipse.org/downloads/download.php\?file\=/technology/epp/downloads/release/luna/R/eclipse-jee-luna-R-linux-gtk-x86_64.tar.gz\&r\=1 | sudo tar xzvf - -C /opt
# sudo ln -s /opt/eclipse/eclipse /usr/bin/eclipse

# http://tecadmin.net/install-tomcat-8-on-centos-rhel-and-ubuntu/
sudo apt-get install -y eclipse tomcat7
sudo usermod -G tomcat7 $(whoami)
/usr/share/tomcat7/bin/shutdown.sh
sudo update-rc.d tomcat7 disable    # Disabling system startup links for /etc/init.d/tomcat7

# install JBoss AS 7.1.1.Final (https://www.digitalocean.com/community/articles/how-to-install-jboss-on-ubuntu-12-10-64bit)
wget -qO- http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz | tar xzvf -
mv jboss-as-7.1.1.Final jboss-as-7.1.1
sudo mv jboss-as-7.1.1 /usr/local/share/jboss
# Because we don't want to run it as root you should create a new user which is used to start the JBoss server.
sudo useradd -M appserver # pwd: appserver
sudo chown -R appserver /usr/local/share/jboss
# su appserver
# cd /usr/local/share/jboss/bin
#./add-user.sh # app1:appserver
# # Now you should create a new Management User by typing "a" and enter later username `app1` and password
# # Start the jBoss
# ./standalone.sh -Djboss.bind.address=127.0.0.1 -Djboss.bind.address.management=127.0.0.1 &
# # http://127.0.0.1:8080/
# # http://127.0.0.1:9990/console
# ./jboss-cli.sh --connect --controller=127.0.0.1:9999 command=:shutdown # to shutdown
# exit
cd ~

# install RVM stable release version (http://rvm.io/rvm/install)
# http://cheat.errtheblog.com/s/rvm
\curl -sSL https://get.rvm.io | bash -s -- --version latest
# enable auto-update
echo 'rvm_autoupdate_flag=2' >> ~/.rvmrc
echo 'export rvm_pretty_print=1' >> ~/.rvmrc
source ~/.rvm/scripts/rvm
#
# In case of any issues read output of 'rvm requirements' and/or 'rvm notes'
# sudo apt-get install build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config

# setup Bundler
bundle config --global jobs 3
# Nokogiri builds and uses a packaged version of libxslt. Use the system library instead
bundle config build.nokogiri --use-system-libraries

# install ruby via RVM
rvm install 1.9.3,2.0.0,$latest_ruby_version,rbx,jruby # java is needed for jruby to run
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
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install wkhtmltopdf (http://wkhtmltopdf.org/)
# Simple shell utility to convert html to pdf using the webkit rendering engine, and qt.
# http://www.installion.co.uk/ubuntu/saucy/universe/w/wkhtmltopdf/index.html
wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
rm wkhtmltox-0.12.1_linux-trusty-amd64.deb

# install addional rails-related applications
sudo apt-get install -y sphinxsearch
# install PostgreSQL
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
# import the repository signing key, and update the package lists
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 libpq-dev
# sudo apt-get install -y libpq-dev # libraries and headers for C language frontend development
sudo apt-get install -y pgadmin3
# https://help.ubuntu.com/10.04/serverguide/postgresql.html
sudo -u postgres psql template1
# ALTER USER postgres with encrypted password 'your_password';
# After configuring the password, edit the file /etc/postgresql/8.4/main/pg_hba.conf to use MD5 authentication with the postgres user:
# local   all         postgres                          md5
sudo /etc/init.d/postgresql restart
sudo update-rc.d postgresql disable

# install Sublime Text 3 (http://www.sublimetext.com/3)
wget -qO- http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2 | tar xjf -
sudo mv sublime_text_3 /opt/ # previously /usr/lib/
sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
sudo ln -s ~/.dotfiles/sublime/subl.desktop /usr/share/applications/subl.desktop
# Open up the file associations list and replace all occurrences of gedit.desktop with subl.desktop.
sudo sed -i 's/gedit\.desktop/subl\.desktop/g' /usr/share/applications/defaults.list
# install CTags (http://blog.codeclimate.com/blog/2012/06/21/sublime-text-2-for-ruby/)
# sudo apt-get install -y exuberant-ctags # no more needed in sublime 3
# add Rust package to sublime

# install ag utility
sudo apt-get install -y silversearcher-ag

# install vim (http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/)
sudo apt-get install -y vim
sudo apt-get install -y gvim
git clone git@ssh.github.com:dskecse/dotvim.git ~/.vim
cd ~/.vim
git submodule update --init
ln -s ~/.vim/vimrc ~/.vimrc
# http://cx4a.org/software/rsense/
cd ~

# install emacs and basic config/plugins (http://appsintheopen.com/articles/1-setting-up-emacs-for-rails-development/part/7-emacs-ruby-foo)
sudo apt-get install -y emacs24
wget -qO- https://github.com/downloads/magit/magit/magit-1.1.1.tar.gz | tar xzvf - # emacs mode for git
cd magit-1.1.1 && make
sudo make install
# require magit in .emacs
cd ~
rm -rf magit-1.1.1/
wget http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/misc/ruby-mode.el
wget http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/misc/ruby-electric.el
sudo mkdir -p /usr/share/emacs/includes
sudo mv ruby-mode.el ruby-electric.el $_
ln -s ~/.dotfiles/emacs/emacs ~/.emacs
# https://github.com/elixir-lang/emacs-elixir

# install ImageMagick/RMagick
sudo apt-get install -y imagemagick
# ImageMagick / RMagick - Can't install RMagick 2.13.1. Can't find Magick-config
sudo apt-get install -y graphicsmagick-libmagick-dev-compat  # fixed it for me on Ubuntu 12.04
# Can't install RMagick 2.13.1. Can't find MagickWand.h.
sudo apt-get install -y libmagickcore-dev libmagickwand-dev # worked for me.

# install Python pip and setuptools (http://www.pip-installer.org/en/latest/installing.html)
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python # will install easy_install & setuptools
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | sudo python # this will install pip
# install libyaml (http://rmcgibbo.github.io/blog/2013/05/23/faster-yaml-parsing-with-libyaml/)
# installing apt-get install python-dev fixes the missing Python.h on Ubuntu
sudo apt-get install -y libyaml-dev python-dev
# install static site generator (http://wok.mythmon.com/docs/) - we use a fork https://github.com/stachern/wok
# http://stackoverflow.com/questions/8247605/configuring-so-that-pip-install-can-work-from-github
# http://jtushman.github.io/blog/2013/06/17/sharing-code-across-applications-with-python/
sudo pip install "https://github.com/stachern/wok/zipball/master"
# install required modules (https://ask.fedoraproject.org/question/10401/how-do-i-use-installed-python-packages-from-pypy/)
# https://github.com/mythmon/wok
sudo pip install pyyaml --upgrade --force
sudo pip install ftptool jinja2 markdown2

# install R (http://cran.rstudio.com/)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
echo "" | sudo tee -a /etc/apt/sources.list
echo "deb http://r.meteo.uni.wroc.pl/bin/linux/ubuntu $(lsb_release -sc)/" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y r-base
sudo apt-get install -y r-base-dev
# install RStudio with R v2.11.1+ (http://www.rstudio.com/ide/download/desktop)
sudo apt-get install -y libjpeg62
wget http://download1.rstudio.org/rstudio-0.97.551-amd64.deb | xargs sudo dpkg -i

# install Go (https://code.google.com/p/go/)
# The Go binary distributions assume they will be installed in /usr/local/go.
\curl -L https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz | sudo tar -C /usr/local -xzf -
# check SHA1 checksum!
# How to write Go code (http://golang.org/doc/code.html)
mkdir ~/gocode
# use github.com/user as base path
mkdir -p $GOPATH/src/github.com/dskecse
cd ~

# install Erlang OTP (https://www.erlang-solutions.com/downloads/download-erlang-otp)
echo "" | sudo tee -a /etc/apt/sources.list
echo "deb http://packages.erlang-solutions.com/debian $(lsb_release -sc) contrib" | sudo tee -a /etc/apt/sources.list
wget -qO - http://packages.erlang-solutions.com/debian/erlang_solutions.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y erlang erlang-manpages
# Erlang/OTP Platform is a complex system composed of many smaller applications (modules).
# Installing the erlang package automatically installs the entire OTP suite.
# run using `erl`

# install Elixir (v1.0.2)
wget -O - https://github.com/elixir-lang/elixir/archive/v1.0.2.tar.gz | tar xzvf -
cd elixir-1.0.2
make install
cd ~

# install Haskell (ghc, cabal, ...)
wget http://www.haskell.org/platform/download/2014.2.0.0/haskell-platform-2014.2.0.0-unknown-linux-x86_64.tar.gz
cd / && sudo tar xvf $HOME/haskell-platform-2014.2.0.0-unknown-linux-x86_64.tar.gz
sudo /usr/local/haskell/ghc-7.8.3-x86_64/bin/activate-hs
cd ~
cabal update
cabal install aeson haskell-src-exts haddock
# for import and LANGUAGE completions and type inference
cabal install ghc-mod

# install Redis (http://redis.io/)
# to use `redis-server` and `redis-cli`
# sudo apt-get install redis-server -y (usually outdated versions)
wget -qO- http://download.redis.io/releases/redis-2.8.12.tar.gz | tar xzf -
sudo mv redis-2.8.12 /opt/redis && cd $_
# install Redis binaries into /usr/local/bin
sudo make install
cd utils
sudo ./install_server.sh
sudo service redis_6379 restart
sudo update-rc.d redis_6379 disable
cd ~

# install MySQL (maybe Percona instead?)
sudo apt-get install -y mysql-server libmysqlclient-dev
# /usr/bin/mysql_secure_installation
sudo apt-get install -y mysql-workbench

# install MongoDB
# sudo update-rc.d mongodb disable

# install ElasticSearch (http://www.elasticsearch.org/download/)
# wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.deb | sudo dpkg -i -
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.deb
sudo dpkg -i elasticsearch-1.3.1.deb
# sudo /usr/share/elasticsearch/bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/elasticsearch-analysis-morphology-1.1.0.zip
# sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-phonetic/1.5.0
# sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/1.10.0
# sudo /usr/share/elasticsearch/bin/plugin -install de.spinscale/elasticsearch-plugin-suggest/0.90.1-0.7
sudo sed -i 's/#network\.host: 192\.168\.0\.1/network\.host: 127\.0\.0\.1/g' /etc/elasticsearch/elasticsearch.yml
# sudo service elasticsearch restart
# sudo update-rc.d elasticsearch disable (disabled by default)

# install memcached
sudo apt-get install -y memcached
sudo service memcached stop
sudo update-rc.d memcached disable

# install samba
# will additionally install tdb-tools (openbsd-inetd inet-superserver smbldap-tools ldb-tools ctdb)
sudo apt-get install -y samba
sudo service samba restart # smbd?

# install nginx
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get install -y nginx
sudo update-rc.d nginx disable

# install Google Chrome (https://www.google.com/intl/en/chrome/browser/)
# sudo mkdir -p /etc/apt/sources.list.d
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# install chromedriver (http://code.google.com/p/chromedriver) - WebDriver for Google Chrome
# WebDriver is an open source tool for automated testing of webapps across many browsers.
# It provides capabilities for navigating to web pages, user input, JavaScript execution, and more.
# ChromeDriver is a standalone server which implements WebDriver's wire protocol for Chromium.
# It is being developed by members of the Chromium and WebDriver teams.
wget http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip # check SHA1 checksum!
sudo unzip chromedriver_linux64.zip -d /usr/local/bin
rm chromedriver_linux64.zip

# install Charles proxy (http://www.charlesproxy.com/documentation/installation/apt-repository/)
wget -qO - http://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
echo "" | sudo tee -a /etc/apt/sources.list
echo "deb http://www.charlesproxy.com/packages/apt/ charles-proxy main"  | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y charles-proxy
# use `charles`

# install skype (http://www.webupd8.org/2014/06/skype-43-for-linux-released-with.html)
# starting with Skype 4.3, the application no longer supports Alsa
# pulseaudio bug fix is in 4.2.0.13 version
# ensure skype is not installed
sudo apt-get remove skype skype-bin:i386 skype:i386
# make sure sni-qt is installed and it's not marked for removal (so you don't lose the Skype AppIndicator)
sudo apt-get install -y sni-qt:i386
echo "" | sudo tee -a /etc/apt/sources.list
echo "deb http://archive.canonical.com/ $(lsb_release -sc) partner" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y skype
skype -v

# totem video player -> vlc player
sudo apt-get remove --purge totem-common -y
sudo apt-get install -y vlc

# some audio player (rhythmbox) -> mplayer
sudo apt-get remove rhythmbox gmusicbrowser -y
sudo apt-get install -y mplayer

# dropbox + dropbox-cli
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-as-a-service-onto-ubuntudebian-servers
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

# brasero -> xfburn
sudo apt-get remove --purge brasero-common -y
sudo apt-get install -y xfburn

sudo apt-get install -y unetbootin

# install Matlab
# http://rutracker.org/forum/viewtopic.php?t=4761942
cd ~/Downloads/Matlab801_MacUnix
./mount_matlab801
cd ~/Matlab801
sudo ./install
# when Segmentation fault (Core Dumped)
# http://braintrekking.wordpress.com/2013/05/14/matlab-r2013a-segmentation-fault-in-ubuntu-12-04-x86-64/
~/Downloads/Matlab801_MacUnix/unmount_matlab801
# http://askubuntu.com/questions/139352/how-do-i-make-a-matlab-launcher-for-unity
# https://help.ubuntu.com/community/MATLAB
# create Matlab Launcher
sudo wget http://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png -O /usr/share/icons/matlab.png
sudo wget 'https://help.ubuntu.com/community/MATLAB?action=AttachFile&do=get&target=matlab-r2012a.desktop' -O /usr/share/applications/matlab.desktop
cd ~

# install Rust (http://www.rust-lang.org/, https://github.com/steveklabnik/rust_for_rubyists)
curl -O http://static.rust-lang.org/dist/rust-0.11.0.tar.gz
tar xzf rust-0.11.0.tar.gz && rm rust-0.11.0.tar.gz
cd rust-0.11.0
./configure --prefix=/usr/local
make && sudo make install
# this will install `rustc` - Rust compiler, `rustdoc` - API-documentation tool
# and `rustpkg` - Rust pkg manager and build system.
cd ~
rustc -v

# use VPN to download ActiveTcl
# f*ck HideMyAss VPN
sudo apt-get install -y openvpn

# install Tk 8.5.15.0 (right now tk v8.6.1 is not supported by Ruby)
# (http://www.tkdocs.com/tutorial/install.html)
wget -qO - http://downloads.activestate.com/ActiveTcl/releases/8.5.15.0/ActiveTcl8.5.15.0.297577-linux-x86_64-threaded.tar.gz | tar xzf -
cd ActiveTcl8.5.15.0.297577-linux-x86_64-threaded/
sudo ./install.sh
cd ~

# install LaTeX
# (http://www.tug.org/texlive/doc/texlive-en/texlive-en.html#installation)
sudo mkdir /mnt/tex
sudo mount /media/dskecse/Seagate/backup/2014-07-13/Downloads/texlive2013-20130530.iso /mnt/tex
sudo perl /mnt/tex/install-tl # -gui
# See /usr/local/texlive/2013/index.html for links to documentation.
# The TeX Live web site contains updates and corrections: http://tug.org/texlive.
sudo umount /mnt/tex
sudo rm -rf /mnt/tex

# install Virtualbox
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt-get install -y virtualbox
# install Virtualbox guest additions
# http://www.binarytides.com/vbox-guest-additions-ubuntu-14-04/
sudo apt-get install -y module-assistant
sudo m-a prepare
# wget http://download.virtualbox.org/virtualbox/4.3.14/Oracle_VM_VirtualBox_Extension_Pack-4.3.14-95030.vbox-extpack
sudo usermod -G vboxusers $USER

# sudo apt-get install -y gnupg # or gpg

# install screenfetch
# http://tuxtweaks.com/2013/12/install-screenfetch-linux/
sudo apt-get install -y scrot
wget -O screenfetch 'https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev'
chmod u+x screenfetch
sudo mv screenfetch /usr/local/bin
screenfetch -s

# install Samsung printer driver
# printer management is at http://localhost:631/admin/
sudo apt-get install -y cups printer-driver-splix

# turn off update popups
gconftool -s --type bool /apps/update-notifier/auto_launch false
gconftool -s --type bool /apps/update-notifier/no_show_notifications true

# install Xmonad wm (and possibly Xmobar)
sudo apt-get install -y xmonad suckless-tools
# install extensions to xmonad
sudo apt-get install -y libghc-xmonad-contrib-dev
xmonad --recompile
xmonad --replace
