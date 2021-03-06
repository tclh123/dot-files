#!/usr/bin/env bash

set -e

PROFILES_DIR=profiles

here="$(cd "${0%/*}"; pwd)"
echo "run $0 at $here"

throw_error () {
  echo $1
  exit 1
}

main () {
  folder=$1
  if ! [[ -d $folder ]]; then
    throw_error "$folder not exists"
  fi
  for file in "$folder"/*; do
    name="$(basename "$file")"
    dotname=".${name}"
    if ! [[ "install readme" =~ $name || -e ~/$dotname || -d $file/.git ]] || [[ -L ~/$dotname ]]; then
      ln -sfnv ${file#$HOME/} "${HOME}/${dotname}"
    fi
  done
}

install_profile () {
  profile=$1
  if [ -z "$profile" ]; then
    throw_error "Please choose one profile to install."
  else
    echo "install profile $profile"
    main "$here/$PROFILES_DIR/$profile"
  fi
}

install_profile $1
