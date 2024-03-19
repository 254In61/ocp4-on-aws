Overview
========
- A directory I use to create the bastion(jump server) EC2.

How to use
==========
1. Your VPC must have been built first.
2. Get the outputs from the VPC and update as variables in your variables.tf file.
3. Set your env variables. $ AWS_PROFILE  is a must!
4. $ terraform init
5. $ terraform apply