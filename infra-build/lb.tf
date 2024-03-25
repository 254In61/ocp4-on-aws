// 1. EXTERNAL NLB

// 1.1 : build external load balancer

resource "aws_lb" "ext-lb" {
  name               = "${var.infra_name}-ext"
  internal           = false     // internet facing
  load_balancer_type = "network"
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id,aws_subnet.public-subnet-3.id ]
  ip_address_type    = "ipv4"


  tags = {
   "Name" = "${var.infra_name}-ext"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}


// 2. INTERNAL NLB
// 2.1 : build internal load balancer

resource "aws_lb" "int-lb" {
  name               = "${var.infra_name}-int"
  internal           = true 
  load_balancer_type = "network"
  subnets            = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id,aws_subnet.private-subnet-3.id ]
  ip_address_type    = "ipv4"

  
  tags = {
   "Name" = "${var.infra_name}-int"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
 }
}