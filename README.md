Overview
========
An ansible tool that tries to automate the steps to create OCPV4 cluster on AWS.

It is such a pain to do it manually, typing the commands as a human being!

REF: https://docs.openshift.com/container-platform/4.14/installing/installing_aws/


How to use
==========

** All this to come under 1 bash script with functions??

1. These prerequisites need to be in place beforehand:
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.
  - Your AWS has an existing VPC.( You can use vpc.yml to build a new one from your computer)

2. Build EC2 instance for your jumphost(bastion). ** Assumption is an Ubuntu Linux Image is used **

3. While in EC2, clone this repo & run $ ./linux-env-prep  ** a script?.. clone >> starts the whole story??

4. Run : $ ./build-manifests.sh
   - Check that the mastersSchedulable parameter in the install-dir/manifests cluster-scheduler-02-config.yml.
   - ensure parameter is set to false.
   - This setting prevents pods from being scheduled on the control plane machines.
   - *** A script for this?? and then combine steps 4 and 5 into 1 bash script??

5. Run : $ ./build-ignition.sh

6. Run : $ ./aws-resources.sh

11. Initialze the bootstrap node on AWS with user-provisioned infrastructure
   - Run : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info


Author
======
Name: 254In61