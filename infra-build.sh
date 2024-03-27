#!/usr/bin/bash

terraform_vars(){
    # One day I will remove Ansible and put Bash or Python script
    echo "" && echo "==> Update terraform.tvars file using ansible"
    cd config-files/ && ansible-playbook terraform-vars.yml && cd ..
}

terraform_iac(){
    echo "" && echo "===> Run terraform IAC"
    cd aws-infra-build/ && terraform init && terraform apply -auto-approve && cd ..
}

echo "" && echo "git pull for updates..."
git pull
build_ignition_files
terraform_iac