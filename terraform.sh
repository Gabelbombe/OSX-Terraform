#!/bin/bash

# Ask for the administrator password upfront
sudo -v

realpath() {
  cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
}

echo Install all AppStore Apps at first!
# no solution to automate AppStore installs
read -p "Press any key to continue... " -n1 -s
echo '\n'

echo Install and Set San Francisco as System Font
ruby -e "$(curl -fsSL https://raw.github.com/wellsriley/YosemiteSanFranciscoFont/master/install)"

echo Install Homebrew, Maria, wget and cask
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew tap homebrew/science

# Update bash
brew install bash
echo "$(which bassh)" |sudo tee -a /etc/shells

# Add fish
brew install fish
echo "$(which fish)" |sudo tee -a /etc/shells

chsh -s "$(which fish)" 

brew install wget
brew install mariadb
## To connect:
##     mysql -uroot
##
## To have launchd start mariadb at login:
##     mkdir -p ~/Library/LaunchAgents
##     ln -sfv /usr/local/opt/mariadb/*.plist ~/Library/LaunchAgents
## Then to load mariadb now:
##     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist
## Or, if you don't want/need launchctl, you can just run:
##     mysql.server start

brew install go
brew install node
brew install ant
brew install ffmpeg
brew install eigen
brew install opencv
npm install -g gitjk
sudo npm install -g cordova
npm install phonegap -g

brew tap phinze/cask
brew install brew-cask

# Core Functionality
echo Install Core Apps
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" little-snitch
brew cask install --appdir="~/Applications" transmit
brew cask install --appdir="~/Applications" vlc
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java

# Required for PHPStorm
brew cask install --appdir="~/Applications" caskroom/homebrew-versions/java6

## get from App Store
#brew cask install --appdir="/Applications" evernote
#brew cask install --appdir="/Applications" wunderlist
#brew cask install --appdir="/Applications" clamxav

# Development
echo Install Dev Apps
brew cask install --appdir="/Applications" heroku-toolbelt
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" phpstorm
brew cask install --appdir="/Applications" pycharm-pro
brew cask install --appdir="/Applications" light-table
brew cask install --appdir="/Applications" macvim
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" charles
brew cask install --appdir="/Applications" easyfind


# Google Slavery
echo Install Google Apps
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" google-chrome-canary
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" google-music-manager
brew cask install --appdir="/Applications" google-earth
brew cask install --appdir="/Applications" chromecast

# Nice to have
echo Install Some additional Apps
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" tilemill
brew cask install --appdir="/Applications" jdownloader
brew cask install --appdir="/Applications" lastfm
brew cask install --appdir="/Applications" all2mp3
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" spotify-notifications

brew install --appdir='/Applications' transmission

# Link Cask Apps to Alfred
brew cask alfred link

# cleanup
brew cleanup --force
rm -fr /Library/Caches/Homebrew/*

echo '.apps' > "${HOME}/.setup"

echo Running other setup scripts

for file in $(realpath)/scripts/*; do
  bash $file
done
