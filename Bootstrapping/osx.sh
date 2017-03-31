#!/bin/bash

if [ `uname -s` = "Darwin" ]
then
  REPOS_ROOT=~/Repositories
else
  REPOS_ROOT=~/repos
fi

REPOS_LIBNAME=pb-envy
PROFILE_PATH="${REPOS_ROOT}/${REPOS_LIBNAME}"

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
  ln -s "${PROFILE_PATH}/Dotfiles/git/gitconfig" "${HOME}/.gitconfig"
fi

if [ `uname -s` = "Darwin" ]
then
  vscode_user_dir="${HOME}/Library/Application Support/Code/User"
  mkdir -p "$vscode_user_dir"
  ln -s "${PROFILE_PATH}/Dotfiles/vscode/user.json" "$vscode_user_dir/"
  ln -s "${PROFILE_PATH}/Dotfiles/vscode/settings.json" "$vscode_user_dir/"

  echo "Setting standard preferences..."
  defaults write com.apple.dock orientation left
  defaults write com.apple.dock pinning end
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write com.apple.Dock autohide-delay -float 0
  defaults write com.apple.Safari NSUserKeyEquivalents -dict-add Back "\U232b"
  defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE
  defaults write com.pilotmoon.scroll-reverser ReverseTrackpad 0
  defaults write com.pilotmoon.scroll-reverser ReverseX 0
  killall Dock

  #echo "Setting up Chrome preferences..."

  #CHROME_STYLESHEET="$HOME/Library/Application Support/Google/Chrome/Default/User StyleSheets/Custom.css"
  #echo "$CHROME_STYLESHEET"
  #rm "$CHROME_STYLESHEET"
  #ln -s "$REPOS_ROOT/$REPOS_LIBNAME/Dotfiles/chrome/Custom.css" "$CHROME_STYLESHEET"
  ln -s "$REPOS_ROOT/$REPOS_LIBNAME/Dotfiles/subl" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
fi

