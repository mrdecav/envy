#!/bin/bash

if [ `uname -s` = "Darwin" ]
then
  REPOS_ROOT=~/Repositories
else
  REPOS_ROOT=~/repos
fi

REPOS_LIBNAME=pb-envy

WRITE_PROFILE="YES"
WRITE_GITIGNORE="YES"
if [ -e ~/.bash_profile ]
then
  echo "A ~/.bash_profile already exists. Do you want to overwrite it? (Y/N/Skip)"
  read response

  case $reponse in
  yY)
    rm ~/.bash_profile
    ;;
  nN)
    echo "Please rename or remove ~/.bash_profile."
    exit 1
    ;;
  *)
    WRITE_PROFILE=""
    ;;
  esac
fi

if [ -e ~/.gitconfig ]
then
  echo "A ~/.gitignore already exists. Do you want to overwrite it? (Y/N/Skip)"
  read response

  case $reponse in
  yY)
    rm ~/.bash_profile
    ;;
  nN)
    echo "Please rename or remove ~/.bash_profile."
    exit 1
    ;;
  *)
    WRITE_GITIGNORE=""
    ;;
  esac
fi

echo "Creating $REPOS_ROOT..."
mkdir $REPOS_ROOT 2> /dev/null

#echo "Checking out the repository..."
#git clone .../envy $REPOS_ROOT/$REPOS_LIBNAME

if [ $WRITE_PROFILE ]
then
  echo "Creating ~/.bash_profile ..."
  echo "export REPOS_ROOT=$REPOS_ROOT" > ~/.bash_profile
  echo "export REPOS_LIBNAME=$REPOS_LIBNAME" >> ~/.bash_profile
  echo "export PROFILE=\"$REPOS_ROOT/$REPOS_LIBNAME/Dotfiles/bash_profile\"" >> ~/.bash_profile
  echo ". \$PROFILE" >> ~/.bash_profile
fi

if [ $WRITE_GITIGNORE ]
then
  ln -s "${REPOS_ROOT}/${REPOS_LIBNAME}/Dotfiles/git/gitconfig" "${HOME}/.gitconfig"
fi

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
  defaults write com.apple.Dock autohide-delay -float 0
  defaults write com.apple.Safari NSUserKeyEquivalents -dict-add Back "\U232b"
  killall Dock

  echo "Setting up Chrome preferences..."

  CHROME_STYLESHEET="$HOME/Library/Application Support/Google/Chrome/Default/User StyleSheets/Custom.css"
  echo "$CHROME_STYLESHEET"
  rm "$CHROME_STYLESHEET"
  ln -s "$REPOS_ROOT/$REPOS_LIBNAME/Dotfiles/chrome/Custom.css" "$CHROME_STYLESHEET"
fi

