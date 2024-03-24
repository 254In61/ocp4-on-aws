#!/usr/bin/bash

base_packages(){
   # Installing jq, yq, wget, curl, unzip, ansible
   echo "" && echo "===>Installing jq, wget, curl, unzip, ansible"
   sudo apt update && sudo apt upgrade
   sudo apt install -y jq wget curl unzip ansible
   
   # Install yq
   # yq is a multifunctional tool that also supports converting YAML to JSON
}

terraform_install(){
   echo "" && echo "===>Installing terraform"
   # 1. You’ll need curl and some software-properties-common packages to add the repository key and repository.
   sudo apt install curl software-properties-common
   
   # 2. Add the HashiCorp Repository
   # Terraform is developed by HashiCorp, and you need to add the HashiCorp GPG (GNU Privacy Guard) key 
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg 
   
   # Once the key is added, add the HashiCorp repository to your system
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

   # Install Terraform
   sudo apt update && sudo apt install terraform

   terraform version
}

terragrunt_install(){
   echo "" && echo "===>Installing terragrunt"
   wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.55.19/terragrunt_linux_arm64
   chmod +x terragrunt_linux_arm64
   sudo mv terragrunt_linux_arm64 /usr/local/bin/terragrunt

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

ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}

build_ignition_files(){
    echo "" && echo "==> Build ignition files"
    ansible-playbook ignition-files.yml
}



base_packages
terraform_install
#terragrunt_install
aws_cli
openshift_packages
ssh_agent
build_ignition_files