Overview
========
An ansible tool that tries to automate the steps to create OCPV4 cluster on AWS.

It is such a pain to do it manually, typing the commands as a human being!

REF: https://docs.openshift.com/container-platform/4.14/installing/installing_aws/


How to use
==========

1. Implement the steps in documentation/prerequisites.md

2. Git clone the project and change directory into the ocpv4-on-aws

3. Build install-config.yml file. : $ ansible-playbook 1-build-install-config.yml

   - The install-config.yml file is built and saved in install-dir/. It is the foundation for the created manifests files.
   - Ensure all the fields are captured as desired.
   - Might need to Update Proxy details ??

4. Build cluster manifests file : $ ansible-playbook 2-build-manifests.yml

   - Your install-dir tree will have lost the 2 directories created for manifest i.e manifests/ and openshift/
   - Check that the mastersSchedulable parameter in the install-dir/manifests/cluster-scheduler-02-config.yml & ensure parameter is set to false.
     This setting prevents pods from being scheduled on the control plane machines.

5. Build ignition files : $ ansible-playbook 3-build-ignition.yml

   - Manifests files will be wrapped into ignition files 1. bootstrap.ign 2.master.ign 3.worker.ign. manifest/ & openshift/ dir will be removed.
   - In addition, there will be metadata.json and auth/ which has the kubeadmin-password and kubeconfig files
   - The Ignition config files contain a unique cluster identifier that you can use to uniquely identify your cluster in Amazon Web Services (AWS). 
     The infrastructure name is also used to locate the appropriate AWS resources during an OpenShift Container Platform installation. 
     The provided CloudFormation templates contain references to this infrastructure name, so you must extract it.
   
   $ jq -r .infraID install-dir/metadata.json

6. Build AWS resources which include vpc, network & loadbalancing , security groups, bootstrap ec2, control-plane(master) ec2s, worker-node ec2s.
   - Run : $ ansible-playbook 4-build-aws-infra.yml

7. Initialze the bootstrap node on AWS with user-provisioned infrastructure
   - Run : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info


Author
======
Name: 254In61