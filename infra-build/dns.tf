// 1. EXTERNAL API ACCESS

/*
- Assumption is there's an existing Public Hosted Zone in the Route 53

*/
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

// 1.2 : build DNS A-record that will route traffic to the external LB
resource "aws_route53_record" "ext-api-record" {
  zone_id = "${var.hosted_zone_id}"
  name    = "api.${var.cluster_name}.${var.hosted_zone_name}"
  type    = "A"

  alias {
    name                   = aws_elb.ext-lb.dns_name
    zone_id                = aws_elb.ext-lb.zone_id
    evaluate_target_health = true
  }
}


// 2. INTERNAL API ACCESS

/*
- Need to build internal load balancer.
- Followed by a Private Hosted Zone
- Under the Private Hosted Zone, build an A record.
- A-Record to route traffic to the internal load balancer.

*/

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

// 2.2 : build private hosted zone 

resource "aws_route53_zone" "private_hosted_zone" {
  name = "${var.cluster_name}.${var.hosted_zone_name}"

  vpc {
    vpc_id = aws_vpc.cluster_vpc.id
    vpc_region = "${var.region}"
  }

  tags = {
   "Name" = "${var.infra_name}-int"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 2.3 : build A record in the private hosted zone

resource "aws_route53_record" "api-int" {
  zone_id = aws_route53_zone.private_hosted_zone.zone_id
  name    = "api-int.${var.cluster_name}.${var.hosted_zone_name}"
  type    = "A"

  alias {
    name                   = aws_lb.int-lb.dns_name
    zone_id                = aws_lb.int-lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api-ext" {
  zone_id = aws_route53_zone.private_hosted_zone.zone_id
  name    = "api.${var.cluster_name}.${var.hosted_zone_name}"
  type    = "A"

  alias {
    name                   = aws_lb.int-lb.dns_name
    zone_id                = aws_lb.int-lb.zone_id
    evaluate_target_health = true
  }
}
