#!/usr/bin/env bash

# stop on error
# set -e

# collect name and email and save it as git config, globally
NAME=$1
EMAIL=$2

if [ -z "$NAME" ]
then
  read -p "Please enter your git user.name, (for example, polatengin)" NAME
  NAME=${NAME:-"polatengin"}
fi

if [ -z "$EMAIL" ]
then
  read -p "Please enter your git user.email, (for example, polatengin[at]outlook[dot]com)" EMAIL
  EMAIL=${EMAIL:-"polatengin@outlook.com"}
fi

git config --global user.name $NAME
git config --global user.email $EMAIL

# clone dotfiles repo
echo $'\n########\nclone dotfiles repo\n'

sudo rm -rf ~/.dotfiles

git clone https://github.com/polatengin/dotfiles.git ~/.dotfiles

# create projects folder
echo $'\n########\ncreate projects folder\n'

sudo mkdir -p /p

# update and upgrade current packages
echo $'\n########\nupdate and upgrade current packages\n'

sudo apt-get update
sudo apt-get -y upgrade

# install global dependencies
echo $'\n########\ninstall global dependencies\n'

sudo apt install -y jq unzip

# install dotnet
echo $'\n########\ninstall dotnet\n'

cd /tmp

sudo apt-get update
sudo apt-get install -y apt-transport-https

DOTNET_VERSION=5.0.0-rc.1.20451.14
ASPNET_VERSION=5.0.0-rc.1.20451.17
DOTNET_SDK_VERSION=5.0.100-rc.1.20452.10

curl -SL --output "dotnet.tar.gz" https://dotnetcli.azureedge.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.tar.gz
tar -ozxf "dotnet.tar.gz" -C "/usr/share/dotnet"

rm -rf "dotnet.tar.gz"

curl -SL --output "aspnetcore.tar.gz" https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/$ASPNET_VERSION/aspnetcore-runtime-$ASPNET_VERSION-linux-x64.tar.gz
tar -ozxf "aspnetcore.tar.gz" ./usr/share/dotnet/shared/Microsoft.AspNetCore.App

rm -rf "aspnetcore.tar.gz"

curl -SL --output "dotnet.tar.gz" https://dotnetcli.azureedge.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz
tar -C "/usr/share/dotnet" -oxzf "dotnet.tar.gz" ./packs ./sdk ./templates ./LICENSE.txt ./ThirdPartyNotices.txt

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

# install terraform
echo $'\n########\ninstall terraform\n'

cd /tmp
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.12.26_linux_amd64.zip
sudo mv terraform /usr/local/bin/

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

# install ncu
echo $'\n########\ninstall ncu\n'

npm install -g npm-check-updates

# install midnight commander
echo $'\n########\ninstall midnight commander\n'

sudo apt-get install -y mc

# make .bash_profile persistent

echo "source ~/.dotfiles/.bash_profile" >> ~/.bashrc

# load .bash_profile
echo $'\n########\nload .bash_profile\n'

source ~/.dotfiles/.bash_profile

# configure git credential manager
echo $'\n########\nconfigure git credential manager\n'

git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"

# done
echo $'\n########\ndone\n'
