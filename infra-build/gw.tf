// INTERNET GATEWAY BUILD

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cluster_vpc.id

  tags                  = {
     "kubernetes.io/cluster/${var.infra_name}" = "owned"
     "Name"                                    = "${var.infra_name}-igw"
  }
}

/*
resource "aws_internet_gateway_attachment" "attach-igw" {
  // Attach igw to vpc
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.cluster_vpc.id
}
*/