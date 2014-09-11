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

echo "=www-client/google-chrome-37.0.2062.94_p1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge google-chrome

sudo emerge mplayer
sudo emerge screenfetch

# Install DE theme
sudo emerge greybird

sudo emerge zsh
# sudo emerge app-shells/zsh-completion
# echo "autoload -U compinit promptinit" >> ~/.zshrc
# echo "compinit" >> ~/.zshrc
# echo "promptinit; prompt gentoo" >> ~/.zshrc

sudo emerge nodejs # does not install npm
echo "=www-client/phantomjs-1.9.7 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge phantomjs

\curl -sSL https://get.rvm.io | bash -s -- --version latest
echo 'export rvm_pretty_print=1' >> ~/.rvmrc
source ~/.rvm/scripts/rvm
unset RUBYOPT
gem install bundler # still unknown command
rvm install 2.1.2
rvm --default 2.1.2
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install rails -v 4.1.5

wget -qO - https://toolbelt.heroku.com/install.sh | sh

# http://michael.orlitzky.com/articles/upgrading_postgresql-9.x_on_gentoo.php
# http://wiki.gentoo.org/wiki/PostgreSQL/QuickStart !!!
sudo emerge dev-db/postgresql-base dev-db/postgresql-server
sudo emerge --config dev-db/postgresql-server
# First, edit /etc/postgresql-NEW/pg_hba.conf and remove the local all all trust line that we added earlier.
# Change 'trust' to 'password' for the localhost connections.
sudo /etc/init.d/postgresql-9.3 start

# Install sublime text 3 (build 3065)
wget -qO- http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2 | tar xjvf -
sudo mv sublime_text_3 /opt/ # previously /usr/lib/
sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl
sudo ln -s ~/.dotfiles/sublime/subl.desktop /usr/share/applications/subl.desktop
# Open up the file associations list and replace all occurrences of gedit.desktop with subl.desktop.
# sudo sed -i 's/gedit\.desktop/subl\.desktop/g' /usr/share/applications/defaults.list

sudo EXTRA_ECONF="--with-png --with-jpeg" emerge imagemagick

wget -qO- http://download.redis.io/releases/redis-2.8.14.tar.gz | tar xzf -
sudo mv redis-2.8.14 /opt/redis && cd $_
sudo make install
cd utils
sudo ./install_server.sh
sudo /etc/init.d/redis_6379 restart
sudo rc-update add redis_6379 default
cd ~

sudo emerge memcached

wget http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip
sudo unzip chromedriver_linux64.zip -d /usr/local/bin
sudo chmod 755 $_/chromedriver
rm chromedriver_linux64.zip

# http://wiki.gentoo.org/wiki/MySQL/Startup_Guide
sudo emerge mysql # installs 9 packages
sudo emerge --config "=dev-db/mysql-5.5_39"
sudo /etc/init.d/mysql start
sudo /usr/bin/mysql_secure_installation

sudo emerge net-misc/dropbox
sudo emerge net-misc/dropbox-cli
dropbox-cli autostart y
dropbox-cli start

echo "=dev-java/oracle-jdk-bin-1.8.0.20 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
wget http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz
sudo mv jdk-8u20-linux-x64.tar.gz /var/calculate/remote/distfiles
sudo emerge dev-java/oracle-jdk-bin

wget http://download.jetbrains.com/cpp/clion-138.1965.18.tar.gz
tar xzvf clion-138.1965.18.tar.gz
sudo mv clion-138.1965.18/ /opt/clion
cd /opt/clion/bin
# install java prior to running the next command
sudo ./clion.sh

# install Erlang OTP (https://www.erlang-solutions.com/downloads/download-erlang-otp)
# Java as a dependency
echo "=dev-lang/erlang-17.1 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge erlang
# Erlang/OTP Platform is a complex system composed of many smaller applications (modules).
# Installing the erlang package automatically installs the entire OTP suite.
# run using `erl`

# install Elixir (v1.0.0)
echo "=dev-lang/elixir-1.0.0 ~amd64" | sudo tee -a /etc/portage/package.keywords/custom
sudo emerge elixir
