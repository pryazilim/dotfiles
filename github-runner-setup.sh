#!/usr/bin/env bash

# stop on error
# set -e


# install azure cli
echo $'\n########\ninstall azure cli\n'

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# install kubectl
echo $'\n########\ninstall kubectl\n'

cd /usr/local/bin
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl

# install helm
echo $'\n########\ninstall helm\n'

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# install kubeval
echo $'\n########\ninstall kubeval\n'

cd /tmp
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo cp kubeval /usr/local/bin

# install node
echo $'\n########\ninstall node\n'

sudo apt install -y nodejs

# install npm
echo $'\n########\ninstall npm\n'

sudo apt install -y npm

# install npm
echo $'\n########\nupgrade packages\n'

sudo apt upgrade

# done
echo $'\n########\ndone\n'
