#!/bin/bash

git submodule init
git submodule update

cd dot-vim
. install.sh

# sudo pip install flake8
