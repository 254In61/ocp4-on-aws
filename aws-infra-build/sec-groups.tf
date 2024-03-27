/* Choosing to use aws_security_group_rule to define the ingress/eggress 
  for re-usability with external sec groups.
*/

// 1. MASTER SEC GROUP

resource "aws_security_group" "master-sg" {
  // name        = "allow_tls"
  description = "Cluster Master Security Group"
  vpc_id = aws_vpc.cluster_vpc.id

  /*
  By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group 
  inside of a VPC. When creating a new Security Group inside a VPC, Terraform will 
  remove this default rule, and require you specifically re-create it if you desire that rule. 
  We feel this leads to fewer surprises in terms of controlling your egress rules. 
  */
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "icmp traffic"
    from_port        = -1
    to_port          = -1
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
  
  /*
  By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group 
  inside of a VPC. When creating a new Security Group inside a VPC, Terraform will 
  remove this default rule, and require you specifically re-create it if you desire that rule. 
  We feel this leads to fewer surprises in terms of controlling your egress rules. 
  */

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "icmp traffic"
    from_port        = -1
    to_port          = -1
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

// 3. BOOTSTRAP SEC GROUP

resource "aws_security_group" "bootstrap-sg" {
  // name        = "allow_tls"
  description = "Cluster bootstrap Security Group"
  vpc_id = aws_vpc.cluster_vpc.id
  
  /*
  By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group 
  inside of a VPC. When creating a new Security Group inside a VPC, Terraform will 
  remove this default rule, and require you specifically re-create it if you desire that rule. 
  We feel this leads to fewer surprises in terms of controlling your egress rules. 
  */

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "19531 traffic"
    from_port        = 19531
    to_port          = 19531
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 
 ingress {
    description      = "ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
   "Name" = "${var.infra_name}-bootstrap-sg"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}