#!/usr/bin/bash

1_prep_ec2(){
    scripts/ec2-env-prep.sh
    eval $(ssh-agent)
}

2_ignition_files(){
    ansible-playbook ignition.yml
}

3_bootstrap(){
    ansible-playbook bootstrap.yml
}

4_master(){
    ansible-playbook master.yml
}

5_initialize_bootstrap(){
    openshift-install wait-for bootstrap-complete --dir=$HOME --log-level info
}

6_worker(){
    ansible-playbook worker.yml
}

1_prep_ec2
2_ignition_files
3_bootstrap
4_master
# 5_initialize_bootstrap
# 6_worker


