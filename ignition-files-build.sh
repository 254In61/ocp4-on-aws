#!/usr/bin/bash
ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}

build_ignition_files(){
    echo "" && echo "==> Build ignition files"
    cd ignition-files/ && ansible-playbook ignition-files.yml && cd ..
}


git pull
ssh_agent
build_ignition_files