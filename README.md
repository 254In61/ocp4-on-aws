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
1. These prerequisites need to be in place beforehand:
  - Access to AWS. You'll need the aws user key and aws access secret key.
  - Access to Redhat to download the needed installation programs and pull-secret.txt.

2. (OPTIONAL) Build an AWS VPC, if not having one: 
  - Clone this repository to your local environment :  $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git
  - Update env-vars file from line 3-8.
  - Set the environmental variables of the EC2 $ source env-vars
  - Ensure you have ansible installed on your local environment. $ sudo apt install -y ansible
  - Run : $ ansible-playbook build-vpc.yml

3. Download from this link : https://console.redhat.com/openshift/install/aws/user-provisioned the openShift installer, pull-secret.txt and Command-line tools
  - OpenShift Installer and Command-line tools will be a .tar.gz files.
  - pull-secret is a .txt file.

4. Build EC2 instance for your jumphost(bastion).
   - You could do this on the AWS console, use Terraform ( jump-server/ ) if you are comfortable with Terraform.
   - Lesson learnt : A small t2, low capacity will have a challenge running the build scripts. Go large on this one!.

5. Clone down the repository to your EC2 Jump Server:
   - ssh into your EC2 
   - Change Directory to ~/  : $ cd $HOME 
   - Transfer the 3 files downloaded in step 3 from your ~/Downloads to this EC2 instance $HOME directory ** Do some chatGPT search here :) :) ***
   - Clone down this git repository : $ git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

4. Set these enviromental variables which the ansible playbooks & bash script will consume.
   - Create $HOME/env-vars file : $ touch $HOME/env-vars  ** You don't want your secrets on git, hence a directory outside this git repo. **
   - Copy files/sample-env-vars to $HOME/env-vars 
   - Update the variables in $HOME/env-vars. 
   - Save the file and move to step 5.

5. Prepare the ec2 linux environment. Run $ scripts/ec2-env-prep.sh

6. Start the ssh agent : $ eval $(ssh-agent)

7. Prepare install-config.yaml file : 
   - 7.1) Include INSTALL_DIR in your environmental variables files : $ echo "export INSTALL_DIR=$HOME" >> $HOME/env-vars
   - 7.2) Set the environmental variables : $ source $HOME/env-vars
   - 7.3) Run the ansible script : $ ansible-playbook build-install-config-yaml.yml

8. Build cluster : $ openshift-install create cluster --dir=${INSTALL_DIR} --log-level debug

Author
======
Name: 254In61