Overview
========
End objective is automate the deployment of OCPV4 on AWS.

It is such a pain to do it manually, typing the commands as a human being!

These steps are documented here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/


How to use
==========

Prerequisites
--------------

- An AWS account 
- An IAM user with the SystemAdministrator role 
- An AWS Key and Secret access key
- A domain name 
- An SSL certificate for the Openshift console 
- Redhat account to download OCP installer, pull-secret and openshift client tools
- Download the Pull-secret from https://console.redhat.com/openshift/install/pull-secret and save is somewhere. 
- Ansible installed in your local environment.

YOUR LOCAL ENVIRONMENT(PC)
--------------------------

1. VPC BUILD 
  - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
  - $ cp template-local-env-vars $HOME/lacal-env-vars 
    - ** You don't want to git commit your AWS secrets by mistake right? That's why we have them outside this git repo**
  - Update the variables in $HOME/local-env-vars. 
    - ** NB : Leave line 1 as it is . DO NOT change the environmental variables names..Just update the value after '='
  - Set your environmental variables : $ source $HOME/local-env-vars
  - Run : $ ansible-playbook vpc-build.yml

2. BASTION/JumpServer EC2 CREATION
  - Create an EC2 to act as Bastion.
  - Go for bigger capacity than the free ones. You will need the cpu and capacity to build the cluster faster.
  - EC2 to be within one of the private subnets
  - Check Output of vpc cloudformation stack

3. SSH INTO BASTION EC2

BASTION EC2
------------

4. CLONE REPOSITORY
   - Change Directory to ~/  : $ cd $HOME 
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
   - $ cd ocpv4-on-aws

5. SET ENVIRONMENTAL VARIABLES
   - $ cp template-ec2-env-vars $HOME/ec2-env-vars 
     - ** You don't want to git commit your AWS secrets by mistake right? That's why we have them outside this git repo**
   - Update the variables in $HOME/env-vars. 
     - *** NB: 1. Leave line 1 as it is . 2. DO NOT change the environmental variables names..Just update the value after '=' **
   - Set your environmental variables : $ source $HOME/ec2-env-vars

6. PREPARE EC2 LINUX ENVIRONMENT
   - Run $ scripts/ec2-env-prep.sh

7. START SSH AGENT
   - Start the ssh agent : $ eval $(ssh-agent)

8. BUILD IGNITION CONFIGURATION FILES
   8.1) Build the install-config.yaml file : $ ansible-playbook install-config-yaml-build.yml
       - Confirm your $HOME/install-config.yaml file is as per your expectaions.
   8.2) Build the manifests files : $ ansible-playbook manifests-build.yml
       - Check the $HOME/manifests files.
   8.3) Build the ignition config files : $ ansible-playbook ignition-build.yml

9. BUILD AWS INFRA
   - Run : $ ansible-playbook aws-resources-build.yml

10. CLUSTER BUILD
   - Run : $ openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug
   - ** This will kickstart terraform scripts that will build the AWS infra upto the end..
   - ** Grab some coffee since it will take some time.

DESTROY AWS RESOURCES
======================
- This just removes what you built on your AWS.
- Run this from your local machine NOT from the Bastion
- $ ansible-playbook destroy.yml

DESTROY CLUSTER
================
- This destroys the cluster and leaves the VPC and Bastion intact
- Destroying based on tag? ***
- Run this from the Bastion

- $ openshift-install destroy cluster --log-level debug
  

Author
======
Name: 254In61