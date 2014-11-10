#!/bin/bash

set -e

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

error () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# Attempt to find private_repo in user's .ssh/config file.
use_private_repo=false
if ! grep "private_repo" ${HOME}/.ssh/config > /dev/null ; then
  user "private_repo not found in .ssh/config, do you want to create an entry for this? (y/n)"
  read -n 1
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    user "Enter repository URI (*just* the domain name - repo path added automatically):"
    read RepoLocation
    user "Enter repository username:"
    read RepoUsername
    
    mkdir -p ${HOME}/.ssh
    if [ ! -f ${HOME}/.ssh/config ]; then
      echo "Host private_repo" > ${HOME}/.ssh/config
    else
      echo "Host private_repo" >> ${HOME}/.ssh/config
    fi
    echo "  HostName $RepoLocation" >> ${HOME}/.ssh/config
    echo "  User $RepoUsername" >> ${HOME}/.ssh/config
    use_private_repo=true
    chmod 600 ${HOME}/.ssh/config
  fi
else
  use_private_repo=true
fi

if [ "$use_private_repo" == "true" ]; then
  # Clone small private dotfiles repo (mostly for mutt and ssh config).
  info "Updating private repo."
  if command -v git > /dev/null; then
    privateRepoLoc=private
    if [ ! -d $privateRepoLoc ]; then
      git clone private_repo:~/repo/dotlitePrivate.git $privateRepoLoc
    else
      pushd $privateRepoLoc > /dev/null
        git pull origin master
      popd > /dev/null
    fi

    info "Updating private"
    pushd $privateRepoLoc > /dev/null
      ./priv.sh
    popd > /dev/null
  else
    echo "Unable to find git, please install it before attempting to pull private repos."
  fi
else
  info "Skipping private repo."
fi
