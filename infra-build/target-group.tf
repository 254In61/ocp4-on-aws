// 1. EXT API TARGET GROUP 

// 1.1 : Create target group - external applications

resource "aws_lb_target_group" "ext-tg" {
  name                 = "${var.infra_name}-aext"
  port                 = 6443
  protocol             = "TCP"
  target_type          = "ip"
  vpc_id               = aws_vpc.cluster_vpc.id
  deregistration_delay = 60

  health_check {
    interval             = 10
    path                 = "/readyz"
    port                 = 6443
    protocol             = "HTTPS"
    healthy_threshold    = 2
    unhealthy_threshold  = 2
  }

  tags = {
   "Name" = "${var.infra_name}-aext"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 1.2 : Create listener rule for the target group

resource "aws_lb_listener" "ext-ls" {
  load_balancer_arn = aws_lb.ext-lb.arn
  port              = "6443"
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ext-tg.arn
  }
}


// 2. INT API TARGET GROUP 

// 2.1 : Create target group - internall applications

resource "aws_lb_target_group" "int-tg" {
  name                 = "${var.infra_name}-aint"
  port                 = 6443
  protocol             = "TCP"
  target_type          = "ip"
  vpc_id               = aws_vpc.cluster_vpc.id
  deregistration_delay = 60

  health_check {
    interval             = 10
    path                 = "/readyz"
    port                 = 6443
    protocol             = "HTTPS"
    healthy_threshold    = 2
    unhealthy_threshold  = 2
  }

  tags = {
   "Name" = "${var.infra_name}-aint"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 2.2 : Create listener rule for the target group

resource "aws_lb_listener" "int-ls" {
  load_balancer_arn = aws_lb.int-lb.arn
  port              = "6443"
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.int-tg.arn
  }
}


// 3. INT SERVICE TARGET GROUP

// 3.1 : Create target group - service applications

resource "aws_lb_target_group" "int-s-tg" {
  name                 = "${var.infra_name}-sint"
  port                 = 22623
  protocol             = "TCP"
  target_type          = "ip"
  vpc_id               = aws_vpc.cluster_vpc.id
  deregistration_delay = 60

  health_check {
    interval             = 10
    path                 = "/healthz"
    port                 = 22623
    protocol             = "HTTPS"
    healthy_threshold    = 2
    unhealthy_threshold  = 2
  }

  tags = {
   "Name" = "${var.infra_name}-sint"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 3.2 : Create listener rule for the target group

resource "aws_lb_listener" "int-s-ls" {
  load_balancer_arn = aws_lb.int-lb.arn
  port              = "22623"
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.int-s-tg.arn
  }
}
