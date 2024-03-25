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