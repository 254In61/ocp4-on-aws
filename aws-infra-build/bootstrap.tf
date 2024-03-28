resource "aws_iam_instance_profile" "bootstrap-instance-profile" {
  name = "${var.infra_name}-bootstrap-instance-profile"
  role = aws_iam_role.BootstrapIamRole.name

  tags = {
   "Name" = "${var.infra_name}-bootstrap-instance-profile"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

resource "aws_instance" "bootstrap" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.bootstrap-instance-profile.name
  instance_type               = "${var.bootstrap_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.bootstrap-sg.id, aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.public-subnet-1.id

  user_data = base64encode(
                templatefile(
                  "${path.module}/bootstrap-user-data.tpl", 
                  { S3Loc = "${var.bootstrap_ignition_location}" } 
                )
            )

  tags = {
   "Name" = "${var.infra_name}-bootstrap"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// Register machine as a Target to LB Target groups

resource "aws_lb_target_group_attachment" "ext-tg-b" {
  target_group_arn = aws_lb_target_group.ext-tg.arn
  target_id        = aws_instance.bootstrap.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-tg-b" {
  target_group_arn = aws_lb_target_group.int-tg.arn
  target_id        = aws_instance.bootstrap.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-s-tg-b" {
  target_group_arn = aws_lb_target_group.int-s-tg.arn
  target_id        = aws_instance.bootstrap.private_ip
  // port             = 80
}
