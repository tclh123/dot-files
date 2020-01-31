#!/bin/bash

here="$(cd "${0%/*}"; pwd)"

mkdir -p ~/bin
echo Adding $HOME/bin to your PATH
export PATH="$HOME/bin:$PATH"

git submodule init
git submodule update

echo installing kubectl ..
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl ~/bin
kubectl version --client

echo installing kube-shell ..
cd $here/kube-shell
if type apt-get; then
  sudo apt-get install -y python3-venv
fi
python3 -mvenv venv
. venv/bin/activate
pip install -e .
ln -sf `pwd`/venv/bin/kube-shell ~/bin/kube-shell
