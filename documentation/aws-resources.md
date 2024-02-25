# Build AWS resources.
# 1. Build a VPC and all what comes with VPC build.

# 2. Create networking and load balancing components.

# 3: create security groups and roles in Amazon Web Services (AWS) for your OpenShift Container Platform cluster to use

# 4. Create the control plane machines in AWS

# 5. Creating the bootstrap node in AWS
  - You must create the bootstrap node in Amazon Web Services (AWS) to use during OpenShift Container Platform cluster initialization.
  - The provided CloudFormation Template assumes that the Ignition config files for your cluster are served from an S3 bucket. If you choose to serve the files from another location, you must modify the templates.
  - So, you build s3 bucket then upload a copy of the bootstrap.ign file there.
  - Then build the bootstrap node using cloudformation stack.

# 6. Initializing the bootstrap node on AWS with user-provisioned infrastructure
  - This is where you start eating your finger nails ... Waiting to see if all goes well.
  - Cross fingures here.. Mbivu na Mbichi ndio yajulikana.
  - If the command exits without a FATAL warning, your OpenShift Container Platform control plane has initialized.

# 7. Create worker nodes in Amazon Web Services (AWS) for your cluster to use.
