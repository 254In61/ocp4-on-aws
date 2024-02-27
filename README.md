Overview
========
An ansible tool that tries to automate the steps to create OCPV4 cluster on AWS.

It is such a pain to do it manually, typing the commands as a human being!

REF: https://docs.openshift.com/container-platform/4.14/installing/installing_aws/


How to use
==========
1. These prerequisites need to be in place beforehand:
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.
  - Your AWS has an existing VPC.( A new one will be built if not there)

** All this to come under 1 playbook??

2. Build EC2 instance for your jumphost(bastion). ** Assumption is an Ubuntu Linux Image is used **

3. While in EC2, clone this repo & run $ ./linux-env-prep  ** a script?.. clone >> starts the whole story??

4. Run : $ ansible-playbook build-manifest.yml
   - Check that the mastersSchedulable parameter in the $HOME/manifests/cluster-scheduler-02-config.yml.
   - ensure parameter is set to false.
   - This setting prevents pods from being scheduled on the control plane machines.
   - *** Automate this then combine step 4 & 5 in one playbook?

5. Run : $ ansible-playbook build-ignition.yml

6. Run : $ ansible-playbook aws-resources.yml

7. Initialze the bootstrap node on AWS with user-provisioned infrastructure
   - Run : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info


Author
======
Name: 254In61