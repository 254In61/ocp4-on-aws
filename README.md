Overview
========
End objective is automate the deployment of OCPV4 on AWS.

It is such a pain to do it manually, typing the commands as a human being!

These steps are documented here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/

Design
=======

- Ansible playbook to build VPC if you need one.
- Ansible playbook that builds the install-config.yaml
- Bash script that prepares the EC2 environment and calls the build-install-config.yml ansible script.


How to use
==========

YOUR LOCAL ENVIRONMENT(PC)
--------------------------

1. PREREQUISITES
  - Reffer to files/prerequisites.md

2. VPC BUILD 
  - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
  - $ cp files/sample-env-vars $HOME/env-vars ** You don't want your secrets on git, hence a directory outside this git repo. **
  - Update the variables in $HOME/env-vars.Leave line 1 as it is . DO NOT change the environmental variables names..Just update the value after '='
  - Set your environmental variables : $ source $HOME/env-vars
  - Run : $ ansible-playbook build-vpc.yml

3. DOWNLOAD ARTIFACTS
  - Download from this link : https://console.redhat.com/openshift/install/aws/user-provisioned 
  - Artifacts to download are :  1. openShift installer(.gz) 2. pull-secret.txt (.txt) 3. Command-line tools (.gz)
 
4. BASTION EC2 CREATION
   - You could do this on the AWS console OR use Terraform tool ( jump-server/ ) if you are comfortable with Terraform.
   - A low capacity will have challenges running the build scripts. Go large on this one!.
   - Needs to be within same subnet as the Nodes.

5. TRANSFER DOWNLOADED ARTIFACTS TO CREATED BASTION EC2
   - Example : $ scp -i "ocpv4-on-aws-key-pair.pem" ~/Downloads/*.gz ubuntu@ec2-3-26-173-139.ap-southeast-2.compute.amazonaws.com:/home/ubuntu
   - Example : $ scp -i "ocpv4-on-aws-key-pair.pem" ~/Downloads/pull-secret.txt ubuntu@ec2-3-26-173-139.ap-southeast-2.compute.amazonaws.com:/home/ubuntu

6. SSH INTO BASTION EC2

BASTION EC2
------------

7. CLONE REPOSITORY
   - Change Directory to ~/  : $ cd $HOME 
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

8. ENVIRONMENTAL VARIABLES
   - $ cp files/sample-env-vars $HOME/env-vars ** You don't want your secrets on git, hence a directory outside this git repo. **
   - Update the variables in $HOME/env-vars.Leave line 1 as it is . DO NOT change the environmental variables names..Just update the value after '='
   - Set your environmental variables : $ source $HOME/env-vars

9. PREPARE EC2 LINUX ENVIRONMENT
   - Run $ scripts/ec2-env-prep.sh

10. START SSH AGENT
   - Start the ssh agent : $ eval $(ssh-agent)

11. BUILD IGNITION CONFIGURATION FILES
   - Run the ansible script : $ ansible-playbook build-ignition-config.yml

12. BUILD AWS INFRA
   - Run : $ ansible-playbook build-aws-resources.yml

13. CLUSTER BUILD
   - Run : $ openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug
   - ** This will kickstart terraform scripts that will build the AWS infra upto the end..
   - ** Grab some coffee since it will take some time.


DESTROY CLUSTER
================
$ openshift-install destroy cluster --log-level debug
  

Author
======
Name: 254In61