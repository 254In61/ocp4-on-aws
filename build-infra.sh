#!/usr/bin/bash

prep_ec2(){
    echo "" && echo "==> Prepare the Bastion EC2 Linux environment"
    scripts/ec2-env-prep.sh
}

ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}


build_infra(){
   
    echo "" && echo "==> Build baseline infra"
    ansible-playbook pre-infra.yml
}


prep_ec2
ssh_agent
build_infra


