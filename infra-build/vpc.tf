// 1. VPC BUILD

resource "aws_vpc" "cluster_vpc" {
  cidr_block            = "${var.vpc_cidr}"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
     "Name"                                    = "${var.infra_name}-vpc"
  }
}

// 2. DHCP OPTIONS 

// 2.1 : Create dhcp option

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name           = "${var.region}.compute.internal"
  domain_name_servers   = ["AmazonProvidedDNS"]

  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 2.2 : Associate dhcp option to vpc

resource "aws_vpc_dhcp_options_association" "dns_resolver_vpc" {
  vpc_id          = aws_vpc.cluster_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

