
# STEP 1. Decide the following:
- Which directory will be your cluster-installation-directory.
- This will be set as an environmental variable in Step 6 below.
- All your files will go here, including your pull-secret.txt(step 3)

# STEP 2. Obtain openshift installation program.
- Log in to https://console.redhat.com/openshift/install
- Go to "Run it yourself" ** Managed Services ** is for managed clusters.
- Chose AWS(X86_64 or ARM?)
- Choose "Full Control" which will be UPI (user-provisioned infrastructure)
- Unpackage openshift-install-linux.tar.gz and have the openshift-install executable in one of your $PATH directories

# STEP 3. Download the installation pull secret from the Red Hat OpenShift Cluster Manager
- Link to download provided on the same page for Step 1.
- This pull secret allows you to authenticate with the services that are provided by the included authorities, including Quay.io, which serves the container images for OpenShift Container Platform components.
- *** Ensure the file is downloaded into your chosen cluster-installation-directory.
- The Ansible playbooks will pick the file from there.

# STEP 4. Download the oc ( OpenShift) command-line tools
- Link provided on same page as Step 1.
- Unpackage the openshift-client-linux.tar.gz and have the oc & kubectl executables in one of your $PATH directories

# STEP 5. Install the following packages:
- boto3 ( pip install boto3 )
- jq
- You should have ansible installed on your machine.. NB.. ansible NOT ansible-core

# STEP 6. Set the below as your local environmental variables.(You could have them in a file and use : $./source <your_file_name>)
- These variables will be read by the ansible playbooks as they run.

   export AWS_REGION=<your aws region>

   export AWS_ACCESS_KEY_ID=<your aws key>

   export AWS_SECRET_ACCESS_KEY=<your aws secret access key>

   export BASE_DOMAIN=<domain name to use>

   export CLUSTER_NAME=<cluster name>

   export INSTALL_DIR=<installation_directory name>    # Directory where all the action happens. Ensure it is outside this git repository to prevent leackage of secrets or sensitive documents online

   export RHCOS_AWS_AMI=<RHCOS AMI for your AWS zone>  # Obtained from the list here: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/installing/installing-on-user-provisioned-aws (Section 2.1.10)

# STEP 7. Confirm the variables in group_vars/common_vars.yaml are all in line with your environment/plan

# STEP 8. Identify the AWS RHCOS AMI to use.
  - Get it from the list here: https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/installing/installing-on-user-provisioned-aws  , Section 2.1.10
