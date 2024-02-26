# 1. These prerequisites need to be in place beforehand:
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.
  - Your AWS has an existing VPC. If not, you can always create one by running $ ansible-playbook vpc.yml from your local dev environment.

# 2. Build EC2 instance for your jumphost(bastion). ** Assumption is an Ubuntu Linux Image is used **
  - Check out Step 03 here : https://www.linkedin.com/pulse/provision-red-hat-openshift-cluster-aws-darshana-dinushal

# 3. While in EC2, clone this repo & run $ ./linux-env-prep

# 4. Build cluster manifests file : 
  - install-config.yml is the seed for the manifests file.
  - manifests files are then wrapped into ignition configuration files which are machine readable.
  - install-config.yml will be consumed then deleted at this stage

   $ ansible-playbook 1-build-install-config.yml
   $ ansible-playbook 2-build-manifests.yml
   - Check that the mastersSchedulable parameter in the install-dir/manifests/cluster-scheduler-02-config.yml & ensure parameter is set to false.
     This setting prevents pods from being scheduled on the control plane machines.

# 5. Build ignition files : $ ansible-playbook 3-build-ignition.yml

   - Manifests files will be wrapped into ignition files 1. bootstrap.ign 2.master.ign 3.worker.ign.
   - manifest/ & openshift/ dir will be removed.
   - There will be metadata.json and auth/ which has the kubeadmin-password and kubeconfig files
   - The Ign config files contain a unique cluster ID that you can use to identify your cluster in AWS. 
   - The infra name is also used to locate the appropriate AWS resources during an OCP installation. 
   - The provided CFN templates contain references to this infrastructure name, so you must extract it.
   
   $ jq -r .infraID install-dir/metadata.json

# 6. Build the network infrastructure including the load balances : $ ansible-playbook 4-ntwk-and-lbs.yml

# 7. Build the security groups and roles : $ ansible-playbook 5-secgrp-and-roles.yml

# 8. Build the bootstrap node : $ ansible-playbook 6-bootstrap.yml

# 9. Build the control-plane nodes : $ ansible-playbook 7-control-plane.yml

# 10. Build the compute-plane nodes : $ ansible-playbook 8-compute-plane.yml

# 11. Initialze the bootstrap node on AWS with user-provisioned infrastructure
   - Run : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info