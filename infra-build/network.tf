##############
# VPC
##############
resource "aws_vpc" "cluster_vpc" {
  cidr_block            = "${var.vpc_cidr}"
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

resource "aws_subnet" "public-subnet-1" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.public_subnet_1.cidr}"
 availability_zone    = "${var.public_subnet_1.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-public-${var.public_subnet_1.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-1" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.private_subnet_1.cidr}"
 availability_zone    = "${var.private_subnet_1.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-private-${var.private_subnet_1.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}