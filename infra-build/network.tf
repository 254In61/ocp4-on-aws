locals {
   vpc_cidr                   = "10.0.0.0/16" 
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
   "Name"                                    = "${each.key}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

