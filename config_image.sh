#!/bin/bash
# Note: you will be prompted to enter the password several times through the script
# run with . config_image.sh
# please note this script is fragile, as public download urls may change

cd ~

# delete standard games
sudo apt-get remove --purge gnome-mines gnome-sudoku gnome-mahjongg aisleriot -y

sudo apt-get update
# sudo apt-get upgrade -y

# install some basic programs
sudo apt-get install -y curl
# Change line endings on files recursively: find path/to/file -type f -exec dos2unix {} +
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
sudo apt-get install -y graphviz
sudo apt-get install -y tree
sudo apt-get install -y lsb-release
sudo apt-get install -y traceroute

# install git
sudo apt-get install -y git gitg # git-core package is obsolete
# git --version
git config --global user.name "Dzianis Dashkevich"
git config --global user.email "dskecse@gmail.com"
git config --global core.editor emacs
git config --global merge.tool vimdiff
git config --global push.default simple
git config --global color.ui true
# You can turn on this functionality with the core.autocrlf setting.
# If you’re on a Windows machine, set it to true — this converts LF endings into CRLF when you check out code:
# git config --global core.autocrlf true
#
# If you’re on a Linux or Mac system that uses LF line endings, then you don’t want Git to automatically convert them when you check out files;
# however, if a file with CRLF endings accidentally gets introduced, then you may want Git to fix it.
# You can tell Git to convert CRLF to LF on commit but not the other way around by setting core.autocrlf to input:
git config --global core.autocrlf input
#
# git config --system receive.denyNonFastForwards true
#
# git config --list # shows list of already added properties
# another useful help
# git config --help
#
# git config --global credential.helper cache # password caching for https authentication
# git config --global credential.helper 'cache --timeout=3600'
# Good to know: The credential helper only works when you clone an HTTPS repo URL. If you use the SSH repo URL instead, SSH keys are used for authentication.
#
# cd ~/.ssh
# ls
# mkdir key_backup
# mv id_rsa* key_backup
#
# OR if not exists
# ssh-keygen -t rsa -C "dskecse@gmail.com"
# Your identification has been saved in /home/you/.ssh/id_rsa.
# Your public key has been saved in /home/you/.ssh/id_rsa.pub.
# xclip -sel clip < ~/.ssh/id_rsa.pub
# ssh -T git@github.com # test it
#
# and the one for bitbucket.org (https://confluence.atlassian.com/display/BITBUCKET/Set+up+SSH+for+Git):
# ssh-keygen -t rsa -C "dskecse@gmail.com"
# /home/dskecse/.ssh/bitbucket_rsa
#
# [alias]
#   co = checkout
#   ci = commit
#   st = status
#   br = branch
#   hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
#   type = cat-file -t
#   dump = cat-file -p

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

# install htop
sudo apt-get install -y htop

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
# That will install phantomjs and any other packages which it depends on.

# Install jslint
cd ~
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
# chsh -s /bin/zsh
# exec /bin/zsh
# Do you have this line in your ~/.zshrc?
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#
curl -L http://install.ohmyz.sh | sh # AUTOMATIC way
# git clone git@github.com:robbyrussel/oh-my-zsh.git ~/.oh-my-zsh # MANUAL way (use when you have ssh keys to authenticate with)
# cp ~/.zshrc ~/.zshrc.orig # OPTIONAL backup existing ~/.zshrc file
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc # create a new zsh config by copying zsh template
# exec /bin/zsh

# install xclip
# to copy file contents into clipboard like: xclip -sel clip < ~/some_file
sudo apt-get install -y xclip

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

# install Oracle GlassFish 4 (https://glassfish.java.net/download.html)


# install RVM stable release version (http://rvm.io/rvm/install)
# http://cheat.errtheblog.com/s/rvm
\curl -sSL https://get.rvm.io | bash -s -- --version latest
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
rvm install 1.9.3,2.0.0,2.1.2,rbx,jruby # java is needed for jruby to run
# rvm reinstall ruby-2.1.2 --with-tcl --with-tk
rvm --default 2.1.2
# rvm docs generate
# export RI="--format ansi"

# install Shoes
# wget -qO- https://github.com/downloads/shoes/shoes/shoes-3.1.0.run
# chmod u+x shoes-3.1.0.run
# sudo $_

# install heroku toolbelt
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
# this will install:
# * Heroku client - CLI tool for creating and managing Heroku apps
# * Foreman - an easy option for running your apps locally
# * Git - revision control and pushing to Heroku
# Once installed, you'll have access to the `heroku` command from your command shell.
#
# The install script will add our repository and key to your apt sources and then have apt install the heroku
# and foreman packages from it. The heroku command line client will be installed
# into /usr/local/heroku and /usr/local/heroku/bin will be added to your PATH.
#
# Log in using the email address and password you used when creating your Heroku account:
#
# heroku login
# Enter your Heroku credentials.
# Email: adam@example.com
# Password:
# Could not find an existing public key.
# Would you like to generate one? [Yn]
# Generating new SSH public key.
# Uploading ssh public key /Users/adam/.ssh/id_rsa.pub
# You're now ready to create your first Heroku app:
#
# cd ~ && mkdir myapp && cd $_
# heroku create
# Creating stark-fog-398... done, stack is cedar
# http://stark-fog-398.herokuapp.com/ | git@heroku.com:stark-fog-398.git
# Git remote heroku added

# install wkhtmltopdf (http://wkhtmltopdf.org/)
# Simple shell utility to convert html to pdf using the webkit rendering engine, and qt.
# http://www.installion.co.uk/ubuntu/saucy/universe/w/wkhtmltopdf/index.html
wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
rm wkhtmltox-0.12.1_linux-trusty-amd64.deb
# if [ ! -f wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2 ] ||
#       [ "$(openssl md5 wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2)" != "$(cat )"]
# then
#   echo 'wkhtmltopdf SHA1 checksums are not identical!'
# else
#   tar xjf wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2
# fi

## GEMS
# install rails 4.1.4
gem install rails -v 4.1.4

# sqlite 3 gem
gem install sqlite3-ruby

# other gems
# gem install rspec
# gem install autotest
# gem install spork
# gem install metric_fu
# gem install debugger
# gem install timecop -v 0.6.1
# gem install chronic -v 0.9.1
# gem install omniauth
# gem install omniauth-twitter
# gem install nokogiri
# gem install ruby-tmdb -v 0.2.1
# gem install ruby-graphviz

# # gem install cucumber-rails
# # gem install cucumber-rails-training-wheels
# # gem install rspec-rails -v 2.6.1
# # gem install nokogiri -v 0.5.0
# # gem install capybara -v 1.1.1
# # gem install rcov -v 0.9.10
# # gem install haml -v 3.1.3
# gem install uglifier -v 1.0.3
# gem install heroku -v 2.8.0
# gem install execjs
# gem install therubyracer
# gem install flog
# gem install flay
# gem install reek
# gem install rails_best_practices
# # gem install churn
# # gem install haml
# gem install simplecov
# # gem install factory_girl
# gem install ruby-tmdb
# gem install taps
# gem install thinking-sphinx
# gem install ruby-debug19

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

# # download rottenpotatoes
# cd ~/Documents
# git clone git://github.com/saasbook/rottenpotatoes
# cd rottenpotatoes
# git checkout -b ch_ruby_intro origin/ch_ruby_intro
# bundle install

# install Sublime Text 2 (http://www.sublimetext.com/2)
# tar xjf when bzip2
# tar xzf when gzip
cd ~
# wget http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2
# tar xjf Sublime\ Text\ 2.0.2\ x64.tar.bz2
wget -qO- http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x64.tar.bz2 | tar xjf -
# mv Sublime\ Text\ 2 sublime2
mv sublime_text_3_build_3059_x64 sublime3
# sudo mv sublime2 /opt/    # previously /usr/lib/
sudo mv sublime3 /opt/
# sudo ln -s /opt/sublime2/sublime_text /usr/bin/subl
sudo ln -s /opt/sublime3/sublime_text /usr/bin/subl
# sudo subl /usr/share/applications/sublime.desktop # create a launcher in Unity
sudo ln -s ~/dotfiles/sublime/subl.desktop /usr/share/applications/subl.desktop
# Open up the file associations list and replace all occurrences of gedit.desktop with subl.desktop.
sudo sed -i 's/gedit\.desktop/subl\.desktop/g' /usr/share/applications/defaults.list
# install CTags (http://blog.codeclimate.com/blog/2012/06/21/sublime-text-2-for-ruby/)
# sudo apt-get install -y exuberant-ctags # no more needed in sublime 3
# add Rust package to sublime

# install vim and rails.vim (http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/)
sudo apt-get install -y vim
# autogenerate .vimrc
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
mkdir .vim && cd $_
wget http://www.vim.org/scripts/download_script.php?src_id=16429
mv download_script* rails.zip
unzip rails.zip
rm -rf rails.zip
# to allow :help rails, start up vim and type :helptags ~/.vim/doc
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
# append to .emacs
ln -s ~/dotfiles/emacs/emacs ~/.emacs

# install ImageMagick/RMagick
sudo apt-get install -y imagemagick
# ImageMagick / RMagick - Can't install RMagick 2.13.1. Can't find Magick-config
sudo apt-get install -y graphicsmagick-libmagick-dev-compat  # fixed it for me on Ubuntu 12.04
#
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
sudo apt-get install -y libjpeg62 # install dependencies
wget http://download1.rstudio.org/rstudio-0.97.551-amd64.deb | xargs sudo dpkg -i


# install Go (https://code.google.com/p/go/)
# The Go binary distributions assume they will be installed in /usr/local/go.
# Extract the archive into /usr/local, creating a Go tree in /usr/local/go:
\curl -L https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz | sudo tar -C /usr/local -xzf -
# check SHA1 checksum!
# How to write Go code (http://golang.org/doc/code.html)
mkdir ~/gocode
# We'll use github.com/user as our base path. Create a directory inside your workspace in which to keep source code:
mkdir -p $GOPATH/src/github.com/dskecse


# install Erlang OTP (https://www.erlang-solutions.com/downloads/download-erlang-otp)
echo "" | sudo tee -a /etc/apt/sources.list
echo "deb http://packages.erlang-solutions.com/debian $(lsb_release -sc) contrib" | sudo tee -a /etc/apt/sources.list
# add the Erlang Solutions public key for `apt-secure`
wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
sudo apt-key add erlang_solutions.asc
rm erlang_solutions.asc
sudo apt-get update
sudo apt-get install erlang erlang-manpages
# Erlang/OTP Platform is a complex system composed of many smaller applications (modules).
# Installing the erlang package automatically installs the entire OTP suite.
# run using `erl`

# install Elixir
wget -O - https://github.com/elixir-lang/elixir/archive/v0.15.1.tar.gz | tar xzvf -
cd elixir-0.15.1
make clean test
cd ~

# # install IntelliJ IDEA
# wget http://download.jetbrains.com/idea/ideaIU-12.1.4.tar.gz | sudo tar -C /usr/local -xzf -
# echo 'PATH=$PATH:/usr/local/idea-IU-129.713/bin' >> ~/.zshrc
# /usr/local/idea/bin/idea.sh
# # Name: BoringFlooders
# # Serial: 92547-R9RUL-A8ZF2-2AUCI-4YJX8-0F5I3

## DBs
# install Redis (http://redis.io/)
# to use redis-server and redis-cli
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
#
# > SET PASSWORD FOR 'user'@'hostname' = PASSWORD('passwordhere');
# > FLUSH PRIVILEGES;
# Type the statement "FLUSH PRIVILEGES;" to update the grant table.
# This statement will update the grant table with any changes to user accounts
# that have been made since the last time the statement was issued or the MySQL server was rebooted.
# sudo update-rc.d mysql disable
sudo apt-get install -y mysql-workbench

# install MongoDB
# sudo update-rc.d mongodb disable

# install ElasticSearch (http://www.elasticsearch.org/download/)
# wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb | xargs sudo dpkg -i -
# sudo /usr/share/elasticsearch/bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/elasticsearch-analysis-morphology-1.1.0.zip
# sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-phonetic/1.5.0
# sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/1.10.0
# sudo /usr/share/elasticsearch/bin/plugin -install de.spinscale/elasticsearch-plugin-suggest/0.90.1-0.7
# echo "network.host: 127.0.0.1" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
# sudo service elasticsearch restart
# sudo update-rc.d elasticsearch disable

# install memcached
sudo apt-get install -y memcached
sudo service memcached restart # [force-reload|restart|start|status|stop]
sudo update-rc.d memcached disable

# install samba
sudo apt-get install -y samba # will additionally install tdb-tools (openbsd-inetd inet-superserver smbldap-tools ldb-tools ctdb)
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
sudo apt-get install google-chrome-stable -y

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
sudo apt-get install charles-proxy -y
# The package creates a "charles" command in /usr/bin, and adds Charles in your application menus in your window manager.

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
# # is advised by skype staff for 64bit Ubuntu users suffering from audio issues
# # sudo apt-get install -y libasound2-plugins:i386
# wget http://skype.com/go/getskype-linux-ubuntu-64
# sudo dpkg -i skype*.deb
# # it will possibly need to meet dependencies
# rm skype*.deb
skype -v

# totem video player -> vlc player
sudo apt-get remove --purge totem-common -y
sudo apt-get install -y vlc

# some audio player (rhythmbox) -> banshee player

# dropbox + dropbox-cli
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
# http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-as-a-service-onto-ubuntudebian-servers
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd
# Download this CLI script to control Dropbox from the command line.
# For easy access, put a symlink to the script anywhere in your PATH.
# http://www.dropboxwiki.com/tips-and-tricks/using-the-official-dropbox-command-line-interface-cli
# whet -q ~/dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
# chmod 755 ~/dropbox.py

# gnumeric spreadsheet - for classes on econometrics
# no LibreOffice -> use Google Docs (Google Drive now)

# brasero -> xfburn
sudo apt-get remove --purge brasero-common -y
sudo apt-get install -y xfburn

# install Tuxboot
sudo apt-add-repository ppa:thomas.tsai/ubuntu-tuxboot
sudo apt-get update
sudo apt-get install -y tuxboot

# install Calibre (format converter and an ebook library)
# sudo apt-get install -y calibre

# install Matlab
# http://rutracker.org/forum/viewtopic.php?t=4761942
cd Downloads/Matlab801_MacUnix
./mount_matlab801
cd ~/Matlab801
sudo ./install
Downloads/Matlab801_MacUnix/unmount_matlab801 # unmount it
# when Segmentation fault (Core Dumped)
# http://braintrekking.wordpress.com/2013/05/14/matlab-r2013a-segmentation-fault-in-ubuntu-12-04-x86-64/
sudo ln -s /usr/local/MATLAB/R2013a/bin/matlab /usr/local/bin/matlab
# http://askubuntu.com/questions/139352/how-do-i-make-a-matlab-launcher-for-unity
# https://help.ubuntu.com/community/MATLAB
# create Matlab Launcher
sudo wget http://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png -O /usr/share/icons/matlab.png
sudo wget 'https://help.ubuntu.com/community/MATLAB?action=AttachFile&do=get&target=matlab-r2012a.desktop' -O /usr/share/applications/matlab.desktop



# install Leiningen (http://leiningen.org/)
# Leiningen is a tool for automating Clojure projects and the easiest way to use Clojure.
# With a focus on project automation and declarative configuration, it gets out of your way and lets you focus on your code.
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod u+x ~/lein
sudo mv ~/lein /usr/bin
lein -v
# Leiningen 2.3.4 on Java 1.7.0_45 Java HotSpot(TM) 64-Bit Server VM

# # install Light Table editor (https://github.com/LightTable/LightTable, http://www.chris-granger.com/lighttable/)
# # installation tips http://ubuntuhandbook.org/index.php/2013/09/install-light-table-ide-create-launcher-ubuntu/
# git clone --depth 1 git@github.com:LightTable/LightTable.git
# cd LightTable
# bash linux_deps.sh
# # compiling cljs, clj, installing jetty and many more...
# mv LightTable/ lighttable
# sudo mv lighttable/ /opt
# sudo apt-get install gnome-panel --no-install-recommends
# sudo gnome-desktop-item-edit /usr/share/applications/ --create-new
# # type in:
# # Name: Light Table
# # command: /opt/lighttable/deploy/LightTable
# # choose icon from /opt/lighttable/deploy/core/img/lticon.png
# cd ~/ && rm -rf LightTableLinux64.tar.gz


# install Rust (http://www.rust-lang.org/, https://github.com/steveklabnik/rust_for_rubyists)
curl -O http://static.rust-lang.org/dist/rust-0.11.0.tar.gz
tar xzf rust-0.11.0.tar.gz && rm rust-0.11.0.tar.gz
cd rust-0.11.0
./configure --prefix=/usr/local
make && sudo make install
# add a RUST_PATH env variable
# and a TEMPDIR as well
#
# this will install `rustc` - Rust compiler, `rustdoc` - API-documentation tool
# and `rustpkg` - Rust pkg manager and build system.
cd ~
rustc -v


# # install gcl (GNU Common Lisp)
# # gcl - GNU common lisp (+ emacs-23)
# sudo apt-get install gcl -y
# # emacs23 emacs23-bin-common emacs23-common emacsen-common gcl libm17n-0 libotf0 m17n-contrib m17n-db tcl8.4 tk8.4
# # (emacs23-el gcl-doc m17n-docs gawk tclreadline)


# set up VPN (HMA Pro) to download ActiveTcl
# https://vpn.hidemyass.com/vpncontrol/myaccounts/welcome/pp
sudo apt-get install -y openvpn
# Linux Software v1.3 (https://www.youtube.com/watch?v=Kuy2C1zN_0k)
wget https://vpn.hidemyass.com/hma-vpn-linux-cli.zip
unzip hma-vpn-linux-cli.zip # is unpacked into ~
rm hma-vpn-linux-cli.zip
./hma-vpn.sh -l
# ./hma-vpn.sh "Canada, Quebec, Montreal (LOC1 S4)"
# or Manual Setup using PPTP & L2TP VPN protocols (https://vpn.hidemyass.com/vpncontrol/myaccounts/pptp)

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
sudo perl /mnt/tex/install-tl -gui
# See /usr/local/texlive/2013/index.html for links to documentation.
# The TeX Live web site contains updates and corrections: http://tug.org/texlive.
sudo umount /mnt/tex
sudo rm -rf /mnt/tex


# install Virtualbox
#
# how do i know where virtualbox is?
# sudo apt-cache policy virtualbox
sudo add-apt-repository multiverse
sudo apt-get update
sudo apt-get install -y virtualbox
# install Virtualbox guest additions
# http://www.binarytides.com/vbox-guest-additions-ubuntu-14-04/
sudo apt-get install -y module-assistant
sudo m-a prepare
# wget http://download.virtualbox.org/virtualbox/4.3.14/Oracle_VM_VirtualBox_Extension_Pack-4.3.14-95030.vbox-extpack
# sudo adduser $USER vboxusers
# or
# sudo gpasswd -a $USER vboxusers
sudo usermod -G vboxusers $USER

# # install Ubuntu HTML5 SDK (http://developer.ubuntu.com/apps/html-5/)
# # http://developer.ubuntu.com/apps/html-5/tutorial/
# sudo add-apt-repository ppa:ubuntu-sdk-team/ppa
# sudo apt-get update
# sudo apt-get install -y qtcreator-plugin-ubuntu # was needed for ubuntu 13.04
# sudo apt-get install -y ubuntu-html5-theme-examples
# # sudo apt-get install -y ubuntu-sdk
# qtcreator -version

# install Birdie as an alternative to a Gwibber twitter client
# sudo add-apt-repository ppa:birdie-team/stable
# sudo apt-get update && sudo apt-get install -y birdie
# # dconf-editor -> com.canonical.indicator.messages -> add birdie.desktop
#
# sudo add-apt-repository ppa:birdie-team/daily
# sudo apt-get update && sudo apt-get install birdie -y

# install keybase
# sudo apt-get install -y gnupg # or gpg
sudo npm install -g keybase-installer
sudo keybase-installer # run the installer, which verifies the latest release
keybase version

# install keepassx
sudo apt-get install -y keepassx

# install screenfetch
# http://tuxtweaks.com/2013/12/install-screenfetch-linux/
sudo apt-get install -y scrot
wget -O screenfetch 'https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev'
chmod u+x screenfetch
sudo mv screenfetch /usr/local/bin
screenfetch -s

# turn off update popups
cd ~
gconftool -s --type bool /apps/update-notifier/auto_launch false
gconftool -s --type bool /apps/update-notifier/no_show_notifications true

# System Settings -> Keyboard -> Shortcuts -> Launchers:
#   Disable `Launch Terminal` command
#   -> Custom Shortcuts -> +
#     Launch Terminator (/usr/bin/terminator) and add Ctrl+Alt+T binding
# Configs at ~/.config/terminator/config
#
# terminator -> tmux

# System Settings -> Mouse and Touchpad -> Touchpad:
#   General:
#     + Disable while typing
#     + Enable mouse clicks with touchpad
#   Scrolling:
#     + 2-finger scrolling
#     + Enable horizontal scrolling

# System Settings -> Power:
#   Suspend when inactive: don't; don't
#   When power is crit low: -
#   When the lid is closed: suspend; suspend
#   show bat status: when bat is charging/in use

# Flash and DRM free formats for ubuntu 13.10
# http://www.omgubuntu.co.uk/2013/10/fixing-amazon-prime-streaming-drm-protected-flash-13-10

# Enable notifications for friends-app!!!:
# dconf-editor -> com - canonical - friends -> Change the "notifications" value to "all"

# gconf is now deprecated - http://en.wikipedia.org/wiki/GConf - and gsettings can be used in its place.
# gsettings set org.gnome.desktop.default-applications.terminal exec 'konsole'
