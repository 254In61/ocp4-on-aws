# At this point we are now installing the OCPV4 on the created AWS Infra in Phase 4 and using the ignition files built in Phase 3

# 1. Accessing RHCOS AMIs with stream metadata

- In OpenShift Container Platform, stream metadata provides standardized metadata about RHCOS in the JSON format and injects the metadata into the cluster. 
- Stream metadata is a stable format that supports multiple architectures and is intended to be self-documenting for maintaining automation.
- You can use the coreos print-stream-json sub-command of openshift-install to access information about the boot images in the stream metadata format. 
- This command provides a method for printing stream metadata in a scriptable, machine-readable format.

- Print the current x86_64 or aarch64 AMI for an AWS region
$ export AWS_REGION=ap-southeast-2
$ openshift-install coreos print-stream-json | jq -r '.architectures.x86_64.images.aws.regions["ap-southeast-2"].image'

ami-0baf6ad81cd8c64c6

** For some reason replacing with $AWS_REGION doesn't give an output.

- The output of this command is the AWS AMI ID for your designated architecture for your region.The AMI must belong to the same region as the cluster.

** Checkout the documentation here : https://docs.openshift.com/container-platform/4.14/installing/installing_aws/installing-aws-user-infra.html if region has no RHCOS AMI or you are uploading customized AMI***

# 2 : Create the bootstrap node in AWS
- You must create the bootstrap node in Amazon Web Services (AWS) to use during OpenShift Container Platform cluster initialization. 
- The provided CloudFormation Template assumes that the Ignition config files for your cluster are served from an S3 bucket. 
- This means you have to create an S3 bucket which will hold the bootstrap.ign ignition file to your cluster.Then upload a copy of the file from your local env to the create S3 bucket.

2.1) Create the S3 bucket: 
$ export CLUSTER_NAME=ocp4-apse2-allan
$ aws s3 mb s3://${CLUSTER_NAME}-infra 

** You can check if it's been created : $ aws s3 ls --region $AWS_REGION | grep infra

2.2) Upload the bootstrap.ign Ignition config file to the bucket
$ aws s3 cp install-dir/bootstrap.ign s3://${CLUSTER_NAME}-infra/bootstrap.ign 

** Verify file is uploaded : 
$ aws s3 ls s3://${CLUSTER_NAME}-infra/
2024-02-21 17:11:59     285255 bootstrap.ign

2.3) Ensure aws-infra-build/params/bootstrap.json has the correct values

**HINT** A good part of them had already been obtained.
** Maybe script with Ansible this one? using Templates and Vars!..
** Will have to get commands to obtain the values though
- The "complex" parameter values ca be found under the Cloudformation >> Netwrk resource stack >> Resources >> Click on them and it leads to the ARNs.

2.4) OPTIONAL : If you are deploying the cluster with a proxy, you must update the ignition in the template to add the ignition.config.proxy fields. Additionally, If you have added the Amazon EC2, Elastic Load Balancing, and S3 VPC endpoints to your VPC, you must add these endpoints to the noProxy field.

2.5) Launch the CloudFormation template to create a stack of AWS resources that represent the bootstrap node
export AWS_REGION=ap-southeast-2
export CLUSTER_NAME=ocp4-apse2-allan
export PREFIX=bootstrap
export STACK_NAME=${CLUSTER_NAME}-${PREFIX}
export TEMPLATE_FILE=file://aws-infra-build/templates/${PREFIX}-template.yaml
export PARAMS_FILE=file://aws-infra-build/params/${PREFIX}-params.json 
aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body ${TEMPLATE_FILE} --parameters ${PARAMS_FILE} --capabilities CAPABILITY_NAMED_IAM --region $AWS_REGION

**  You must explicitly declare the CAPABILITY_NAMED_IAM capability because the provided template creates some AWS::IAM::Role and AWS::IAM::InstanceProfile resources.

2.6) Obtain outputs for usage up ahead :  
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.

# 3. Create the control plane machines in AWS

3.1) Update the control-plane-params.json with the right values 
** Needs to be scripted!!

You must create the control plane machines in Amazon Web Services (AWS) that your cluster will use.
- I left Instance Type to be default as in the control-plane-template.yaml

3.2) Launch the CloudFormation template to create a stack of AWS resources that represent the control plane nodes
export AWS_REGION=ap-southeast-2
export CLUSTER_NAME=ocp4-apse2-allan
export PREFIX=control-plane
export STACK_NAME=${CLUSTER_NAME}-${PREFIX}
export TEMPLATE_FILE=file://aws-infra-build/templates/${PREFIX}-template.yaml
export PARAMS_FILE=file://aws-infra-build/params/${PREFIX}-params.json 
aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body ${TEMPLATE_FILE} --parameters ${PARAMS_FILE} --region $AWS_REGION

3.3) Obtain outputs for usage up ahead : 
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.

# 4. Create the worker nodes in AWS

4.1) Update the worker-node-params.json with the right values 
** Needs to be scripted!!
- I left Instance Type to be default as in the worker-node-template.yaml

4.2) Launch the CloudFormation template to create a stack of AWS resources that represent the control plane nodes
export AWS_REGION=ap-southeast-2
export CLUSTER_NAME=ocp4-apse2-allan
export PREFIX=worker-node
export STACK_NAME=${CLUSTER_NAME}-${PREFIX}
export TEMPLATE_FILE=file://aws-infra-build/templates/${PREFIX}-template.yaml
export PARAMS_FILE=file://aws-infra-build/params/${PREFIX}-params.json 
aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body ${TEMPLATE_FILE} --parameters ${PARAMS_FILE} --region $AWS_REGION

4.3) Obtain outputs for usage up ahead : 
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.

# 5. Initializing the bootstrap sequence on AWS with user-provisioned infrastructure
After you create all of the required infrastructure in Amazon Web Services (AWS), you can start the bootstrap sequence that initializes the OpenShift Container Platform control plane.

$ openshift-install wait-for bootstrap-complete --dir install-dir --log-level=info 
INFO Waiting up to 20m0s (until 9:56PM AEST) for the Kubernetes API at https://api.ocp4-apse2-allan.lab-aws.ldcloud.com.au:6443... 
INFO API v1.27.10+28ed2d7 up                      
INFO Waiting up to 30m0s (until 10:06PM AEST) for bootstrapping to complete...


** Cross fingures here.. Mbivu na Mbichi ndio yajulikana.
** If the command exits without a FATAL warning, your OpenShift Container Platform control plane has initialized.

- After the control plane initializes, it sets up the compute nodes and installs additional services in the form of Operators.