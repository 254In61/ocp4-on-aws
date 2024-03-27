##############
# SUBNETS
##############

// TO BE MADE DRY WITH TERRAGRUNT AT SOME POINT

// availability zone a 

resource "aws_subnet" "public-subnet-1" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.a.pub_cidr}"
 availability_zone    = "${var.a.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-public-${var.a.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-1" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.a.priv_cidr}"
 availability_zone    = "${var.a.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-private-${var.a.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}

// availability zone b

resource "aws_subnet" "public-subnet-2" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.b.pub_cidr}"
 availability_zone    = "${var.b.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-public-${var.b.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-2" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.b.priv_cidr}"
 availability_zone    = "${var.b.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-private-${var.b.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}

// availability zone c

resource "aws_subnet" "public-subnet-3" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.c.pub_cidr}"
 availability_zone    = "${var.c.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-public-${var.c.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

resource "aws_subnet" "private-subnet-3" {
 vpc_id               = aws_vpc.cluster_vpc.id
 cidr_block           = "${var.c.priv_cidr}"
 availability_zone    = "${var.c.az_name}"
 
 tags = {
   "Name" = "${var.infra_name}-private-${var.c.az_name}"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
   "kubernetes.io/role/internal-elb"         = ""
 }
}