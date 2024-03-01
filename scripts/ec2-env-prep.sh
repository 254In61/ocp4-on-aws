#!/usr/bin/bash

# Script that builds the cluster.

packages(){
   # Installing jq, yq, wget, curl, unzip, ansible
   echo "" && echo "===>Installing jq, yq, wget, curl, unzip, ansible, pip"
   sudo apt update
   sudo apt install -y jq wget curl unzip ansible python3-pip
   pip install boto3
   # Install yq
   # yq is a multifunctional tool that also supports converting YAML to JSON
   sudo snap install yq
   
}

aws_cli(){
   echo "" && echo "===> installing AWS CLI"
   # AWS CLI
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -o -q awscliv2.zip
   sudo ./aws/install
   rm -rf awscliv2.zip
}

openshift_packages(){
   echo "" && echo "===> installing openshift-install"
   # Unzip OpenShift installer >> Move $PATH directory and test if executable works
   tar -xvzf $HOME/openshift-install-linux.tar.gz && sudo cp openshift-install /usr/local/bin/ && openshift-install version

   # Unzip OpenShift client >> Move to $PATH directory and test if executable works
   echo "" && echo "==> installing openshift-client cmd packages"
   tar -xvzf $HOME/openshift-client-linux.tar.gz && sudo cp oc /usr/local/bin/ && sudo cp kubectl /usr/local/bin/
   rm -rf kubectl
   rm -rf oc
   rm -rf openshift-install
   oc version && kubectl version --short

}

set-vars(){
    # Set env variables
    echo "" && echo "==> Set environmental variables"
    echo "export INSTALL_DIR=$HOME" >> $HOME/env-vars
    source ~/env-vars
}

# build-install-config-yaml(){
#     # Prepare install-config.yml
#     echo "" && echo "==> Build install-config.yml file"
#     ansible-playbook build-install-config-yaml.yml
# }

# install-cluster(){
#     # Install cluster
#     echo "" && echo "==> Build cluster"
#     openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug
# }

packages
aws_cli
openshift_packages
set-vars