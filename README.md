Overview
========
An ansible tool that tries to automate the steps to create OCPV4 cluster on AWS using Ansible.

These steps are documented here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/

It is such a pain to do it manually, typing the commands as a human being!

How to use
==========
1. These prerequisites need to be in place beforehand:
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.

2. Build an AWS VPC: 
  - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
  - Update env-vars file from line 3-8.
  - Set the environmental variables of the EC2 $ source env-vars
  - Ensure you have ansible installed on your local environment. $ sudo apt install -y ansible
  - Run : $ ansible-playbook build-vpc.yml

3. Download from this link : https://console.redhat.com/openshift/install/aws/user-provisioned the openShift installer, pull-secret.txt and Command-line tools
  - OpenShift Installer and Command-line tools will be a .tar.gz files.
  - pull-secret is a .txt file.

4. Build EC2 instance for your jumphost(bastion) within the same vpc build in STEP 2 and within the Public IP Subnet. 
  - ** Assumption is an Ubuntu Linux Image is used **
   - You could do this on the AWS console, use Terraform, Python boto3 or Ansible

5. Clone down the repository to your EC2 Jump Server:
   - ssh into your EC2 
   - Change Directory to ~/  : $ cd $HOME 
   - Transfer the 3 files downloaded in step 3 from your ~/Downloads to this EC2 instance $HOME directory ** Do some chatGPT search here :) :) ***
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git


4. Set these enviromental variables which the ansible playbooks will consume.
   - Create env-vars on your $HOME and put in the details found in sample-env-vars
   - Update sample-env-vars file from line 3-8.
   - ** RHCOS AMI ID is Obtained from the list here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/ (Chapter 2.1.10)
   - Set the environmental variables of the EC2 $ source env-vars

5. Prepare the EC2 Linux environment : $ scripts/ec2-env-prep.sh

6. Start the ssh agent : $ eval $(ssh-agent)

6. Create OCPV4 cluster installation files for AWS : $ ansible-playbook build-installation-files.yml

7. Create AWS infrustructure : $ ansible-playbook build-aws-resources.yml

8. Initialze the bootstrap node on AWS with UPI : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info


Author
======
Name: 254In61