#!/bin/bash

REPOS_ROOT=~/dev
REPOS_LIBNAME=envy
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

