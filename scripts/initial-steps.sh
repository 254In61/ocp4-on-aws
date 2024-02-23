#!/usr/bin/bash

# Automating localhost (or installation box) for the installation up ahead.
# Refer to PHASE2-host-prep.md for dtails
# Assumptions : All Prerequisite steps documented in PHASE1-Prerequisites.md have been implemented.


# Set the director within $PATH you want to use
export PATH_DIR=/home/amaseghe/bin/ # Could be any dir in your $PATH

create_directories(){
    # Create a directory to hold the OpenShift Container Platform installation files:
    echo "" && echo "Create a directory to hold the OpenShift Container Platform installation files"
    mkdir clusterconfig
    
    # Create an installation directory
    echo "" && echo "Create an installation directory"
    mkdir install-dir
    

}

open_shift_install(){
    # Extract the installation program & mv execution program to $PATH 
    echo "" && echo "Extract the installation program"
    tar -xvf ~/Downloads/openshift-install-linux.tar.gz
    mv ~/Downloads/openshift-install $PATH_DIR  
}

oc_and_kubectl(){
    # Extract the command-line tools and mv to $PATH
    echo "" && echo "Extract the command-line tools"
    tar -xvf ~/Downloads/openshift-client-linux.tar.gz
    mv oc $PATH_DIR
    mv kubectl $PATH_DIR
}

generate_ssh_key_pair(){
    # Generating a key pair for cluster node SSH access
    # During an OpenShift Container Platform installation, you can provide an SSH public key to the installation program. 
    # The key is passed to the Red Hat Enterprise Linux CoreOS (RHCOS) nodes through their Ignition config files and is used to authenticate SSH access to the nodes. You will need to ssh to perfom installation debuggin or disaster recovery.
    # The key is added to the ~/.ssh/authorized_keys list for the 'core' user on each node, which enables password-less authentication.
    # You must use a local key, not one that you configured with platform-specific approaches such as AWS key pairs.
    # Do not skip this procedure in production environments, where disaster recovery and debugging is required.
    echo "" && echo "Generating a key pair for cluster node SSH access"
    ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
    echo "" && echo "Add the SSH private key identity to the SSH agent for your local user"
    ssh-add ~/.ssh/id_ed25519
}

butane_install(){
    # Butane is a tool used to generate Ignition config files from a Butane config.
    # Butane translates human-readable Butane Configs(.bu) into machine-readable Ignition Configs(.yaml)
    echo "" && echo "Install butane"
    curl https://mirror.openshift.com/pub/openshift-v4/clients/butane/latest/butane --output butane
    chmod +x butane
    mv butane $PATH_DIR
}

config-file(){
    # Generate install-config.yaml file
    echo "" && echo "Generate install-config.yaml file"
    openshift-install create install-config --dir install-dir/
}

create_directories
open_shift_install
oc_and_kubectl
generate_ssh_key_pair
butane_install
config-file