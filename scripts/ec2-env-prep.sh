#!/usr/bin/bash
sudo apt update && sudo apt install -y jq wget curl unzip ansible
sudo pip install boto3
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install

# Install yq
# yq is a multifunctional tool that also supports converting YAML to JSON:
sudo snap install yq

# Start ssh agent
eval $(ssh-agent)


# Download openshift-install and openshift-client packages(https://console.redhat.com/openshift/install)
# Download Links for the 2 should have been obtained before hand through the RedHat console.
# Also download the pull-secret.txt and transfer it to the EC2 $HOME.

wget $OCP_INSTALLER_DOWNLOAD_LINK  && wget $OCP_CLIENT_DOWNLOAD_LINK

# Unzip OpenShift installer >> Move to $PATH directory and test if executable works
tar -xvzf openshift-install-linux.tar.gz && sudo cp openshift-install /usr/local/bin/ && openshift-install version

# Unzip OpenShift client >> Move to $PATH directory and test if executable works
tar -xvzf openshift-client-linux.tar.gz && sudo cp oc /usr/local/bin/ && sudo cp kubectl /usr/local/bin/
oc version && kubectl version --short

