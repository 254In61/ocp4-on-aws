#!/usr/bin/bash

packages(){
   # Installing jq, yq, wget, curl, unzip, ansible
   echo "" && echo "===>Installing jq, yq, wget, curl, unzip, ansible"
   sudo apt update
   sudo apt install -y jq wget curl unzip ansible

   # Install yq
   # yq is a multifunctional tool that also supports converting YAML to JSON
   sudo snap install yq
}

python_boto3(){
   echo "" && echo "==> installing python boto3"
   # Needed for the AWS Ansible packages.
   python3 -m pip install boto3
}

aws_cli(){
   echo "" && echo "==> installing AWS CLI"
   # AWS CLI
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
   sudo ./aws/install
}

openshift_packages(){

   # Unzip OpenShift installer >> Move $PATH directory and test if executable works
   tar -xvzf $HOME/openshift-install-linux.tar.gz && sudo cp openshift-install /usr/local/bin/ && openshift-install version

   # Unzip OpenShift client >> Move to $PATH directory and test if executable works
   tar -xvzf $HOME/openshift-client-linux.tar.gz && sudo cp oc /usr/local/bin/ && sudo cp kubectl /usr/local/bin/
   oc version && kubectl version --short

}

ssh_agent(){
   
   echo "" && echo "==> Start the ssh agent"
   # Start ssh agent
   eval $(ssh-agent)
}

packages
python_boto3
aws_cli
openshift_packages
ssh_agent





