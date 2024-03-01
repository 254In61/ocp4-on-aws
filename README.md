Overview
========
End objective is automate the deployment of OCPV4 on AWS.

It is such a pain to do it manually, typing the commands as a human being!

Will you call this API or UPI?? In this , we are just updating the install-config.yaml file then running the openshift-install tool.

These steps are documented here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/

Design
=======

- Ansible playbook to build VPC if you need one.
- Ansible playbook that builds the install-config.yaml
- Bash script that prepares the EC2 environment and calls the build-install-config.yml ansible script.


How to use
==========
1. PREREQUISITES
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.

2. (OPTIONAL) VPC BUILD 
  - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
  - Update env-vars file from line 3-8.
  - Set the environmental variables of the EC2 $ source env-vars
  - Ensure you have ansible installed on your local environment. $ sudo apt install -y ansible
  - Run : $ ansible-playbook build-vpc.yml

3. DOWNLOAD ARTIFACTS
  - Download from this link : https://console.redhat.com/openshift/install/aws/user-provisioned 
  - 1. the openShift installer 2. pull-secret.txt 3. Command-line tools
  - OpenShift Installer and Command-line tools will be a .tar.gz files.
  - pull-secret is a .txt file.

4. EC2 CREATION
   - You could do this on the AWS console, use Terraform ( jump-server/ ) if you are comfortable with Terraform.
   - Lesson learnt : A small t2, low capacity will have a challenge running the build scripts. Go large on this one!.

5. TRANSFER ARTIFACTS(STEP 3) TO EC2
   - Example : $ scp -i "ocpv4-on-aws-key-pair.pem" ~/Downloads/*.gz ubuntu@ec2-3-26-173-139.ap-southeast-2.compute.amazonaws.com:/home/ubuntu
   - Example : $ scp -i "ocpv4-on-aws-key-pair.pem" ~/Downloads/pull-secret.txt ubuntu@ec2-3-26-173-139.ap-southeast-2.compute.amazonaws.com:/home/ubuntu

6. CLONE REPOSITORY INTO EC2
   - ssh into your EC2 
   - Change Directory to ~/  : $ cd $HOME 
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

7. ENVIRONMENTAL VARIABLES
   - $ touch $HOME/env-vars  ** You don't want your secrets on git, hence a directory outside this git repo. **
   - Copy files/sample-env-vars into $HOME/env-vars 
   - Update the variables in $HOME/env-vars.
   - NB: 1) Update ONLY lines 3-7, leave line 1 & 2 as they are. 2) DO NOT change the environmental variables names..Just update the value after '='
   - Set your environmental variables : $ source $HOME/env-vars

8. PREPARE EC2 LIMUX ENVIRONMENT
   - Run $ scripts/ec2-env-prep.sh

9. SSH AGENT
   - Start the ssh agent : $ eval $(ssh-agent)

10. INSTALL-CONFIG.YAML  
   - 7.1) Include INSTALL_DIR in your environmental variables files : $ echo "export INSTALL_DIR=$HOME" >> $HOME/env-vars
   - 7.2) Set the environmental variables : 
   - 7.3) Run the ansible script : $ ansible-playbook build-install-config-yaml.yml

11. SET AWS CREDS
   - Run : $ ansible-playbook write-aws-creds.yml

12. CLUSTER BUILD
   - Run : $ openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug

Author
======
Name: 254In61