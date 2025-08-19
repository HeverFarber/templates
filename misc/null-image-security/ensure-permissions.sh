#!/usr/bin/env bash
set -e -x

# list installed apk packages
apk list --installed

# list installed python packages
pip3 list

# from base image
node --version
npm --version
yarn --version

#from alpine repos
bash --version
git --version
python3 --version
pip3 --version
jq --version
openssl version
ssh -V
curl --version

# other
aws --version
awsv2 --version
gcloud --version
az --version
kubectl version --client
tfenv --version
tgenv --version
infracost --version
helm version

# Check write permissions
touch /tmp/test
rm /tmp/test
touch /home/node/test
rm /home/node/test
mkdir -p /home/node/.cache
python3 -m venv -h
helm repo add env0 https://env0.github.io/self-hosted
helm repo update
helm show chart env0/env0-agent

# Check packages install
pip install --break-system-packages --user ansible
ansible --version

npm install -g @env0/cli
env0 help
