#!/usr/bin/bash
ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}

build_ignition_files(){
    # One day I will remove Ansible and put Bash or Python script
    echo "" && echo "==> Build ignition files"
    cd ignition-files/ && ansible-playbook ignition-files.yml && cd ..
}

terraform_iac(){
    echo "" && echo "===> Change directory to run terraform"
    cd infra-build/ && terraform init && terraform apply && cd ..
}

echo "" && echo "git pull for updates..."
git pull
ssh_agent
build_ignition_files
terraform_iac