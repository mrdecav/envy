#!/bin/bash

if [ `uname -s` = "Darwin" ]
then
  REPOS_ROOT=~/Repositories
else
  REPOS_ROOT=~/repos
fi

REPOS_LIBNAME=pb-envy

if [ -e ~/.bash_profile ]
then
  echo "A ~/.bash_profile already exists. Do you want to overwrite it? (Y/N)"
  read response

  if [[ ($response != "y") && ($response != "Y") ]]
  then
    echo "Please rename or remove ~/.bash_profile."
    exit 1
  fi

  rm ~/.bash_profile
fi

echo "Creating $REPOS_ROOT..."
mkdir $REPOS_ROOT 2> /dev/null

echo "Checking out the repository..."
svn checkout http://internal.pelebyte.net/svn/envy $REPOS_ROOT/$REPOS_LIBNAME

echo "Creating ~/.bash_profile ..."
echo "export REPOS_ROOT=$REPOS_ROOT" > ~/.bash_profile
echo "export REPOS_LIBNAME=$REPOS_LIBNAME" >> ~/.bash_profile
echo "export PROFILE=\"$REPOS_ROOT/$REPOS_LIBNAME/Dotfiles/bash_profile\"" >> ~/.bash_profile
echo ". \$PROFILE" >> ~/.bash_profile

if [ `uname -s` = "Darwin" ]
then
  echo "Setting up Library aliases to Dropbox..."
  for APP in LicenseKeeper OmniGraffle
  do
    SRCDIR="$HOME/Dropbox/Libraries/$APP"
    TARGETDIR="$HOME/Library/Application Support/$APP"

    if [ -e "$TARGETDIR" ]
    then
      rm -r "$TARGETDIR"
    fi

    echo "    Creating symlink for $APP..."
    ln -s "$SRCDIR" "$TARGETDIR"
  done

  echo "Setting standard preferences..."
  defaults write com.apple.dock orientation left
  defaults write com.apple.dock pinning end
  defaults write com.apple.dock expose-animation-duration -float 0.1
  killall Dock
fi
