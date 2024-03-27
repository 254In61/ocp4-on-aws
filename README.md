Overview
========
End objective is automate the deployment of OCPV4 on AWS.

It is such a pain to do it manually, typing the commands as a human being!

These steps are documented here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/


Assumptions
=============
- Bastion AWS Machine architecture used is ARM.
- Bastion EC2 AMI is Ubuntu Server 22.*

How to use
==========
1. Create your bastion. Use AWS EC2 to ensure connectivity assurance during the cluster install stage.
2. SSH into the EC2 bastion.
3. Git clone this repo.
4. Set env variables as they are in env-vars.
5. Add to $HOME the pull-secret.txt obtained from https://console.redhat.com/openshift/install/pull-secret.
6. Prepare the bastion environment by running the script : $ ./bastion.sh
7. Build ignition config files by running the script     : $./ignition.sh
8. Build aws infra resources by running the script       : $ ./infra.sh

DESTROY AWS RESOURCES
======================
- This just removes what you built on your AWS.
- Run this from your local machine NOT from the Bastion
- $ ansible-playbook destroy.yml

DESTROY CLUSTER
================
- This destroys the cluster and leaves the VPC and Bastion intact
- $ openshift-install destroy cluster --log-level debug


FUTURE IMPROVEMENTS
===================
=> Yeeees! Looots of repetition in this code!
=> Need to go DRY!..Terragrunt will do that for me... I just need to find time for it.
  

Author
======
Name: 254In61