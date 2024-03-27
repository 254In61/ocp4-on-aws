#!/usr/bin/bash

# Keep this separate from constant restart!
# Whenever restarted a new infra name is created and that means destroying of
# terraform-build infra and rebuilding new ones!

ssh_agent(){
    echo "" && echo "==> Start the ssh agent"
    eval $(ssh-agent)
}

build_ignition_files(){
    # One day I will remove Ansible and put Bash or Python script
    echo "" && echo "==> Build ignition files"
    cd config-files/ && ansible-playbook ignition-files.yml && cd ..
}

echo "" && echo "git pull for updates..."
git pull
ssh_agent
build_ignition_files