#!/usr/bin/bash

prep_ec2(){
    scripts/ec2-env-prep.sh
    eval $(ssh-agent)
}

ignition_files(){
    ansible-playbook ignition.yml
}

lab_dns(){
    ansible-playbook aws-services.yml
}

bootstrap(){
    ansible-playbook bootstrap.yml
}

master(){
    ansible-playbook master.yml
}

initialize_bootstrap(){
    openshift-install wait-for bootstrap-complete --dir=$HOME --log-level info
}

worker(){
    ansible-playbook worker.yml
}

prep_ec2
ignition_files
lb_dns
bootstrap
master
# 5_initialize_bootstrap
# 6_worker


