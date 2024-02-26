
# STEP 1. Decide the following:
- Which directory will be your cluster-installation-directory.( To be set as an environmental variable : export INSTALL_DIR=<installation_directory name> )
- All your files will go here, including your pull-secret.txt(step 3)

# STEP 2. Obtain openshift installation program + Pull secret + Client application programs
- 2.1) Log in to https://console.redhat.com/openshift/install >> "Run it yourself" (Managed Services is for managed clusters.>> "Full Control" which will be UPI (user-provisioned infrastructure)
- 2.2) Download openshift-install-linux.tar.gz + openshift-client-linux.tar.gz + pull-secret 
- 2.3) Unpackage the *.tar.gz files and have the executable programs in one of your $PATH directories.
  
  $ tar xvf openshift-client-linux.tar.gz && tar xvf openshift-install-linux.tar.gz 
  
  $ sudo mv kubectl /usr/local/bin/ && sudo mv oc /usr/local/bin/ && sudo mv openshift- /usr/local/bin/

- 2.4) Ensure the pull-secret is located in your chosen cluster-installation-directory.The Ansible playbooks will pick the file from there.
  Pull-secret: allows you to authenticate with the services that are provided by the included authorities, including Quay.io, which serves the container images for OpenShift Container Platform components.
  
# STEP 3. Install the following packages in your Linux environment:
- boto3 ( pip install boto3 )
- jq
- ansible-core
- aws-cli

# STEP 4. Set the below as your local environmental variables.(You could have them in a file and use : $./source <your_file_name>)
- These variables will be read by the ansible playbooks as they run.

   export AWS_REGION=<your aws region>

   export AWS_ACCESS_KEY_ID=<your aws key>

   export AWS_SECRET_ACCESS_KEY=<your aws secret access key>

   export BASE_DOMAIN=<domain name to use>

   export CLUSTER_NAME=<cluster name>

   export INSTALL_DIR=<installation_directory name>    
   - Directory where all the action happens. Ensure it is outside this git repository to prevent leackage of secrets or sensitive documents online

   export RHCOS_AWS_AMI=<RHCOS AMI for your AWS zone>  
   - Obtained from the list here: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/installing/installing-on-user-provisioned-aws (Section 2.1.10)

# STEP 5. Confirm the variables in group_vars/common_vars.yaml are all in line with your environment/plan

# STEP 6. Identify the AWS RHCOS AMI to use.
  - Get it from the list here: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/installing/installing-on-user-provisioned-aws  , Section 2.1.10
