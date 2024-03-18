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

PHASE 1 : ON YOUR LOCAL ENVIRONMENT(PC)
-----------------------------------------
1. CLONE REPO & ENV VARIABLES
   1.1)Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
   1.2)Create local environmental variables file & update your local env: 
      - $ cp template-local-env-vars $HOME/local-env-vars 
      - ** You don't want to git commit your AWS secrets by mistake right? That's why we have them outside this git repo**
      - Update the variables in $HOME/local-env-vars. 
      - ** NB : Leave line 1 as it is . DO NOT change the environmental variables names..Just update the value after '='
      - Set your environmental variables : $ source $HOME/local-env-vars

2. SET AWS CREDENTAILS
   - $ ansible-playbook aws-creds.yml

3. VPC BUILD 
   - Run : $ ansible-playbook vpc-build.yml

4. BASTION/JumpServer EC2 CREATION
   - Create an EC2 to act as Bastion. 
     - NB: The scripts/ec2-env-prep.sh(Step 5) is designed for an Ubuntu OS & running on AWS ARM Architecture
   - Go for bigger capacity than the free ones. You will need the cpu and capacity to build the cluster faster.
   - EC2 to be within one of the public subnets
   - Check Output of vpc cloudformation stack

5. SSH INTO BASTION EC2

PHASE 2 : ON BASTION EC2
-------------------------

1. CLONE REPOSITORY
   1.1) Change Directory to ~/  : $ cd $HOME 
   1.2) Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
   1.3) $ cd ocpv4-on-aws

2. SET ENVIRONMENTAL VARIABLES
   2.1) $ cp template-ec2-env-vars $HOME/ec2-env-vars 
     - ** You don't want to git commit your AWS secrets by mistake right? That's why we have them outside this git repo**
   2.2) Update the variables in $HOME/env-vars. 
     - *** NB: 1. Leave line 1 as it is . 2. DO NOT change the environmental variables names..Just update the value after '=' **
   2.3) Set your environmental variables : $ source $HOME/ec2-env-vars

3. COPY PULL-SECRET TO $HOME
   - Yes! There's a script that will read it from here.
   - If you change this lots could go wrong ;) ..Don't say I didn't warn you!
   - $ cat > ~/pull-secret.txt
     - Copy paste your pull-secret data here.
     - cntl + c to exit and save.

4. PREPARE EC2 LINUX ENVIRONMENT
   - Run $ scripts/ec2-env-prep.sh

5. START SSH AGENT
   - Start the ssh agent : $ eval $(ssh-agent)

6. BUILD IGNITION CONFIGURATION FILES
   - $ ansible-playbook ignition-build.yml
   - NB: Backups for all created files will be created just incase you need to troubleshoot.

7. BUILD AWS INFRA
   7.1) Build network and load balancers : $ ansible-playbook network.yml
   
   
11. CLUSTER BUILD
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