echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

echo "Setting up the shell..."
mkdir ~/dev
cd ~/dev
git clone https://github.com/mrdecav/envy.git
cd envy/Bootstrapping
./osx.sh
. ~/.bash_profile

echo "Installing packages..."
brew install wget
brew cask install 1password
brew cask install google-chrome
brew cask install sublime-text
brew cask install google-drive
brew cask install intellij-idea
brew cask install slack
brew cask install microsoft-office
brew cask install spotify
brew cask install zoomus
brew cask install sketchbook
