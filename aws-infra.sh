#!/usr/bin/bash

prep_ec2(){
    echo "" && echo "==> Prepare the Bastion EC2 Linux environment"
    scripts/ec2-env-prep.sh
}

ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}


ignition_files(){
   
    echo "" && echo "==> Build ignition configuration files"
    ansible-playbook ignition.yml
}

aws_services(){
    echo "" && echo "==> Build dns, loadbalancers, sec groups and IAM roles"
    ansible-playbook aws-services.yml
}

bootstrap(){
    echo "" && echo "==> Build bootstrap machine"
    ansible-playbook bootstrap.yml
}

master(){
    echo "" && echo "==> Build cluster master nodes"
    ansible-playbook master.yml
}

prep_ec2
ssh_agent
ignition_files
aws_services
bootstrap
master


