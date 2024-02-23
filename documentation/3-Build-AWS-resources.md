# Build AWS resources.
## To be scripted?? Using Ansible? Python? Bash?

# 1. Build a VPC and all what comes with VPC build.
 $ export CLUSTER_NAME=ocp4-apse2-allan
 $ export STACK_NAME=${CLUSTER_NAME}-vpc
 $ export AWS_REGION=ap-southeast-2
 $ aws cloudformation create-stack --stack-name $STACK_NAME --region $AWS_REGION--template-body file://aws-infra-build/templates/vpc-template.yaml

 {
    "StackId": "arn:aws:cloudformation:ap-southeast-2:603695592254:stack/ocpv4-lab-vpc-build/0f55e9f0-cfab-11ee-85e3-0a49506c6685"
 }

 => Run the command : 
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.

# 2. Create networking and load balancing components.
- You must configure networking and classic or network load balancing in Amazon Web Services (AWS) that your OpenShift Container Platform cluster can use.

2.1) Update the aws-infra-build/params/network-params.json with the correct values.

    - Obtain the hosted zone ID for the Route 53 base domain that you specified in the install-config.yaml file for your cluster. 
    $ aws route53 list-hosted-zones-by-name --dns-name <route53_domain> 
    $ aws route53 list-hosted-zones-by-name --dns-name lab-aws.ldcloud.com.au

    - To get the infrastructureName ( Ref : Documentation/PHASE3-generating-file.md step 7): 
      $ jq -r .infraID install-dir/metadata.json 
        ocp4-apse2-allan-g9kff

    - Subnets and VpcId are found in Step 1.

2.2) Launch the CloudFormation template to create a stack of AWS resources that provide the networking and load balancing components:
 
 $ export AWS_REGION=ap-southeast-2
 $ export STACK_NAME=${CLUSTER_NAME}-network-resources
 $ aws cloudformation create-stack --stack-name $STACK_NAME --region $AWS_REGION --template-body file://aws-infra-build/templates/network-template.yaml --parameters file://aws-infra-build/params/network-params.json --capabilities CAPABILITY_NAMED_IAM

 => Run the command : 
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.


# 3: create security groups and roles in Amazon Web Services (AWS) for your OpenShift Container Platform cluster to use

3.1) Update the aws-infra-build/params/sec-groups-params.json with the correct values.
** All the values can be obtained in aws-infra-build/params/network-params.json.

3.2) Launch the CloudFormation template to create a stack of AWS resources that represent the security groups and roles
$ export STACK_NAME=${CLUSTER_NAME}-sec-groups
$ aws cloudformation create-stack --stack-name $STACK_NAME --region $AWS_REGION --template-body file://aws-infra-build/templates/sec-groups-template.yaml --parameters file://aws-infra-build/params/sec-groups-params.json --capabilities CAPABILITY_NAMED_IAM

=> Run the command : 
 $ aws cloudformation describe-stacks --stack-name ${STACK_NAME} --region $AWS_REGION

 - StackStatus displays CREATE_COMPLETE. "Outputs" displays values for the parameters you will need up ahead.
 - Save that output somewhere, you will need it.

