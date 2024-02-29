#!/usr/bin/bash

# Script that builds the cluster.

jump_host(){
   # 1: Prepare the ec2-jump-server.
   scripts/ec2-env-prep.sh
}

set-vars(){
    # Set env variables
    echo "" && echo "==> Set environmental variables"
    source ~/env-vars
}

build-install-config-yaml(){
    # Prepare install-config.yml
    echo "" && echo "==> Build install-config.yml file"
    ansible-playbook build-install-config-yaml.yml
}

install-cluster(){
    # Install cluster
    echo "" && echo "==> Build cluster"
    openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug
}


jump_host
set-vars
build-install-config-yaml
install-cluster