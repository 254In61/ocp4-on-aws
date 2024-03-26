/* Choosing to use aws_security_group_rule to define the ingress/eggress 
  for re-usability with external sec groups.
*/

// 1. MASTER SEC GROUP

resource "aws_security_group" "master-sg" {
  // name        = "allow_tls"
  description = "Cluster Master Security Group"
  vpc_id = aws_vpc.cluster_vpc.id

  ingress {
    description      = "icmp traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }
 
 ingress {
    description      = "ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }

 ingress {
    description      = "api traffic"
    from_port        = 6443
    to_port          = 6443
    protocol         = "TCP"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }
 
 ingress {
    description      = "ignition files access"
    from_port        = 22623
    to_port          = 22623
    protocol         = "TCP"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }

  tags = {
   "Name" = "${var.infra_name}-master-sg"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}

// 2. WORKER SEC GROUP

resource "aws_security_group" "worker-sg" {
  // name        = "allow_tls"
  description = "Cluster Worker Security Group"
  vpc_id = aws_vpc.cluster_vpc.id

  ingress {
    description      = "icmp traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }
 
 ingress {
    description      = "ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = [aws_vpc.cluster_vpc.cidr_block]
  }

  tags = {
   "Name" = "${var.infra_name}-worker-sg"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}