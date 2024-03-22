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

Assumptions
-----------
- AWS Machine architecture used is ARM for ALL the EC2s i.e Bastion, Bootstrap, Master, Worker.
- Bastion EC2 AMI is Ubuntu Server 22.*

PHASE 1 : ON YOUR LOCAL ENVIRONMENT(PC)
-----------------------------------------
1. CLONE REPO
   - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

2. SET ENVIRONMENTAL VARIABLES
   - Set your local environmental variables found in env-vars.

3. VPC BUILD 
   - Run : $ ansible-playbook vpc-build.yml

4. BASTION/JumpServer EC2 CREATION
   - Create an EC2 to act as Bastion within the VPC created and within one of the Public Subnets
   - You could use terraform IAC in bastion/

5. SSH INTO BASTION EC2

PHASE 2 : ON BASTION EC2
-------------------------

1. CLONE REPOSITORY
   - $ cd $HOME && git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
   
2. SET ENVIRONMENTAL VARIABLES
   - Set your local environmental variables found in env-vars.

3. PULL-SECRET
   - Add to $HOME the pull-secret.txt obtained from https://console.redhat.com/openshift/install/pull-secret.

4. AWS INFRA
  - Run : $ ./build-infra.sh

10. INITIALIZE BOOTSTRAP 
   - $ openshift-install wait-for bootstrap-complete --dir=$HOME --log-level info
   - If the command exits without a FATAL warning, your production control plane has initialized.

11. BUILD WORKER NODES
   - $ ansible-playbook worker.yml

DESTROY AWS RESOURCES
======================
- This just removes what you built on your AWS.
- Run this from your local machine NOT from the Bastion
- $ ansible-playbook destroy.yml

DESTROY CLUSTER
================
- This destroys the cluster and leaves the VPC and Bastion intact
- $ openshift-install destroy cluster --log-level debug
  

Author
======
Name: 254In61