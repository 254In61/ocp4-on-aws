##############
# SUBNETS
##############

// TO BE MADE DRY WITH TERRAGRUNT AT SOME POINT

// availability zone a 

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

// availability zone b

resource "aws_subnet" "public-subnet-2" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.public_subnet_2.cidr}"
 availability_zone    = "${var.public_subnet_2.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-public-${var.public_subnet_2.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-2" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.private_subnet_2.cidr}"
 availability_zone    = "${var.private_subnet_2.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-private-${var.private_subnet_2.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}

// availability zone c

resource "aws_subnet" "public-subnet-3" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.public_subnet_3.cidr}"
 availability_zone    = "${var.public_subnet_3.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-public-${var.public_subnet_3.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-3" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.private_subnet_3.cidr}"
 availability_zone    = "${var.private_subnet_3.az}"
 
 tags = {
   "Name"                                    = "${var.infra_name}-private-${var.private_subnet_3.az}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}