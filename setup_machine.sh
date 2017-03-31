/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install wget

mkdir ~/dev
cd ~/dev
git clone https://github.com/mrdecav/envy.git
cd envy/Bootstrapping
./osx.sh


