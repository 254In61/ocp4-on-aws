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

  - set these environmental variables:

    export AWS_REGION=<Your AWS Region>

    export AWS_ACCESS_KEY_ID=<Your AWS Access key ID>

    export AWS_SECRET_ACCESS_KEY=<Your AWS Secret access key>

  - Ensure you have ansible installed on your local environment. $ sudo apt install -y ansible

  - Run : $ ansible-playbook build-vpc.yml

3. Build EC2 instance for your jumphost(bastion) within the same vpc you will be using. ** Assumption is an Ubuntu Linux Image is used **
   - You could do this on the AWS console, use Terraform, Python boto3 or Ansible

3. Clone down the repository to your EC2 Jump Server:
   - ssh into your EC2 
   - Change Directory to ~/  : $ cd $HOME 
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

4. Set these enviromental variables which the ansible playbooks will consume.

   export AWS_REGION=<Your AWS Region>

   export AWS_ACCESS_KEY_ID=<Your AWS Access key ID>

   export AWS_SECRET_ACCESS_KEY=<Your AWS Secret access key>

   export BASE_DOMAIN=<Your base domain>

   export CLUSTER_NAME=<Your chosen ocpv4 cluster name >

   export INSTALL_DIR=$HOME

   export RHCOS_AWS_AMI=<RHCOS AWS AMI ID>  # Obtained from the list here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/ (Chapter 2.1.10)

5. Prepare the EC2 Linux environment : $ scripts/ec2-env-prep.sh

6. Create OCPV4 cluster installation files for AWS : $ ansible-playbook build-installation-files.yml

7. Create AWS infrustructure : $ ansible-playbook build-aws-resources.yml

8. Initialze the bootstrap node on AWS with UPI : $ openshift-install wait-for bootstrap-complete --dir=${INSTALL_DIR} --log-level info


Author
======
Name: 254In61