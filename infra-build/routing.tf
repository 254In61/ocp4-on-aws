// 1. INTERNET GATEWAY BUILD

resource "aws_internet_gateway" "igw" {
  // Creates IGW and attaches to the vpc
  vpc_id = aws_vpc.cluster_vpc.id

  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
     "Name"                                    = "${var.infra_name}-igw"
  }
}

// 2. PUBLIC ROUTE TABLE
// 2.1 : Create rt and attach default route
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.cluster_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
     "Name"                                    = "${var.infra_name}-public"
  }
}

// 2.2 : Associate public subnets to public rt
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-rt.id
}

// PRIVATE ROUTE TABLES ??