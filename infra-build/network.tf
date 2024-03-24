locals {
   aws_region                 = run_cmd("echo", "$REGION")
   cluster_name               = run_cmd("echo", "$CLUSTER_NAME")
   infra_name                 = run_cmd("jq", "-r", ".infraID", "$HOME/metadata.json")
   vpc_cidr                   = "10.0.0.0/16"
   k8s_base_tag_key           = "kubernetes.io/cluster/${local.infra_name}"

   tags                       = {
      local.k8s_base_tag_key  = "owned"
   } 
}

// COMMON
variable "infra_name"{
  // obtained as a dynamic variable
  type    = string
}

variable "region"{
  type    = string
  default = "ap-southeast-2"
}

variable "cluster_name"{
  // obtained as a dynamic varible
  type    = string
}


// Dynamically obtain infra name value
// Use the external data source to call an external program/script

data "external" "infra_name" {
  program = ["bash", "-c", "echo 'output_value=$(jq -r .infraID ~/metadata.json)'"]
}

data "external" "cluster_name" {
  program = ["bash", "-c", "echo 'output_value=$(echo $CLUSTER_NAME)'"]
}

##############
# VPC
##############
resource "aws_vpc" "create_vpc" {
  cidr_block            = "${local.vpc_cidr}"
  enable_dns_hostnames  = true
  enable_dns_support    = true
  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
     "Name"                                    = "${var.cluster_name}-vpc"
  }

}

##############
# SUBNETS
##############

// TO BE MADE DRY WITH TERRAGRUNT AT SOME POINT

resource "aws_subnet" "create_subnets" {
 for_each             = "${var.cluster_vpc_subnets}"
 vpc_id               = aws_vpc.my_vpc.id
 cidr_block           = each.value.cidr
 availability_zone    = each.value.az
 
 tags = {
   Name = "${each.key}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

