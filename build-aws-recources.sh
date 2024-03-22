#!/usr/bin/bash

ignition_files(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)

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

initialize_bootstrap(){
    echo "" && echo "==> Initialize Bootstrap"
    openshift-install wait-for bootstrap-complete --dir=$HOME --log-level info
}

worker(){
    echo "" && echo "==> Build cluster worker nodes"
    ansible-playbook worker.yml
}

prep_ec2
ignition_files
aws_services
bootstrap
master
# 5_initialize_bootstrap
# 6_worker


