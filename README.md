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
  - $ cp env-vars-files/sample-local-env-vars $HOME/env-vars ** You don't want your secrets on git, hence a directory outside this git repo. **
  - Update the variables in $HOME/local-env-vars. 
     ** NB : Leave line 1 as it is . DO NOT change the environmental variables names..Just update the value after '='
  - Set your environmental variables : $ source $HOME/local-env-vars
  - Run : $ ansible-playbook build-vpc.yml

2. BASTION EC2 CREATION
   - You could do this on the AWS console OR use Terraform tool ( jump-server/ ) if you are comfortable with Terraform.
   - If you use the terraform tool, ensure you update the variables.tf file to reflect your correct values
   - A low capacity will have challenges running the build scripts. Go large on this one!.
   - Needs to be within same subnet as the Nodes.

3. SSH INTO BASTION EC2

BASTION EC2
------------

4. CLONE REPOSITORY
   - Change Directory to ~/  : $ cd $HOME 
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

5. SET ENVIRONMENTAL VARIABLES
   - $ cp files/sample-ec2-env-vars $HOME/env-vars ** You don't want your secrets on git, hence a directory outside this git repo. **
   - Update the variables in $HOME/env-vars. 
     *** NB: 1. Leave line 1 as it is . 2. DO NOT change the environmental variables names..Just update the value after '=' **
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


DESTROY CLUSTER
================
$ openshift-install destroy cluster --log-level debug
  

Author
======
Name: 254In61