#!/usr/bin/bash

# Script that builds the cluster.

packages(){
   # Installing jq, yq, wget, curl, unzip, ansible
   echo "" && echo "===>Installing jq, yq, wget, curl, unzip, ansible, pip, tree"
   sudo apt update
   sudo apt install -y jq wget curl unzip ansible python3-pip tree
   pip install boto3
   # Install yq
   # yq is a multifunctional tool that also supports converting YAML to JSON
   sudo snap install yq
}

aws_cli(){
   echo "" && echo "===> installing AWS CLI"
   # AWS CLI
   curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip -o -q awscliv2.zip
   sudo ./aws/install
   rm -rf awscliv2.zip
}

openshift_packages(){
   echo "" && echo "===> Download the packages"
   wget $INSTALLER_DOWNLOAD_LINK && wget $CLI_DOWNLOAD_LINK
   mv openshift-* $HOME

   echo "" && echo "===> installing openshift-install"
   # Unzip OpenShift installer >> Move $PATH directory and test if executable works
   sudo tar -xvzf $HOME/openshift-install-linux.tar.gz -C /usr/local/bin/

   # Unzip OpenShift client >> Move to $PATH directory and test if executable works
   echo "" && echo "==> installing openshift-client cmd packages"
   sudo tar -xvzf $HOME/openshift-client-linux.tar.gz -C /usr/local/bin/

   # Confirm packages have been installed.
   echo "" && echo "==> Confirm packages installed by checking versions"
   echo "" && openshift-install version
   echo "" && oc version
   echo "" && kubectl version

   ## To be checked??
   ## bash: /usr/local/bin/openshift-install: cannot execute binary file: Exec format error?? 
   ## Could it be to do with permissions? What's the permission ?
}

packages
aws_cli
openshift_packages