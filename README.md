Overview
========
An ansible tool that tries to automate the steps to create OCPV4 cluster on AWS.

It is such a pain to do it manually, typing the commands as a human being!

REF: https://docs.openshift.com/container-platform/4.14/installing/installing_aws/

Prerequisites
=============
1. Obtain openshift installation program.
- Log in to https://console.redhat.com/openshift/install
- Go to "Run it yourself" ** Managed Services ** is for managed clusters.
- Chose AWS(X86_64 or ARM?)
- Choose "Full Control" which will be UPI (user-provisioned infrastructure)
- Ensure the packaged file is downloaded into ~/Downloads

2. Download the installation pull secret from the Red Hat OpenShift Cluster Manager
- Link to download provided on the same page for Step 1.
- This pull secret allows you to authenticate with the services that are provided by the included authorities, including Quay.io, which serves the container images for OpenShift Container Platform components.
- Ensure the file is downloaded into ~/Downloads

3. Download the oc ( OpenShift) command-line tools
- Link provided on same page as Step 1.
- Ensure the packaged file is downloaded into ~/Downloads

4. Set the below as your local environmental variables.(You could have them in a file and use : $./source <your_file_name>)
   
   export PATH_DIR=<dir within $PATH to hold your executable files>

   export DOMAIN_NAME=<domain name to use>

   export CLUSTER_NAME=<cluster name>

   export AWS_REGION=<your aws region>

   export AWS_ACCESS_KEY_ID=<your aws key>

   export AWS_SECRET_ACCESS_KEY=<your aws secret access key>

   export SSH_KEY_ROOT_DIR=<Where your ssh keys are eg  ~/.ssh>

   export MASTER_REPLICAS=<How many master nodes?>

   export WORKER_REPLICAS=<How many worker nodes?>

How to use
==========

1. Git clone the project and change directory into the ocpv4-on-aws

2. Run : $ ansible-playbook env-prep.yml

3. Run : $ ansible-playbook build-install-config.yml

   - The install-config.yml file is built and saved in install-dir/.
   - Ensure all the fields are captured as desired.
   - Might need to Update Proxy details ??

4. Run : $ ansible-playbook build-manifests.yml

   - Check that the mastersSchedulable parameter in the install-dir/manifests/cluster-scheduler-02-config.yml.
   - Ensure parameter is set to false.
   - This setting prevents pods from being scheduled on the control plane machines

5. Run : $ ansible-playbook build-ignition.yml

   - At this point your install-dir tree will have lost the 2 directories created for manifest i.e manifests/ and openshift/
   - Instead you'll have ignition files 1. bootstrap.ign 2.master.ign 3.worker.ign.
   - In addition, there will be metadata.json and auth/ which has the kubeadmin-password and kubeconfig files
   - The Ignition config files contain a unique cluster identifier that you can use to uniquely identify your cluster in Amazon Web Services (AWS). The infrastructure name is also used to locate the appropriate AWS resources during an OpenShift Container Platform installation. The provided CloudFormation templates contain references to this infrastructure name, so you must extract it.
   
   $ jq -r .infraID install-dir/metadata.json 

6. 


Author
======
Name: 254In61