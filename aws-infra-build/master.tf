// YES! This duplicated code will be fixed with Terragrunt!

resource "aws_iam_instance_profile" "master-instance-profile" {
  name = "${var.infra_name}-master-instance-profile"
  role = aws_iam_role.MasterIamRole.name

  tags = {
   "Name" = "${var.infra_name}-master-instance-profile"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

resource "aws_instance" "master-0" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.master-instance-profile.name
  instance_type               = "${var.master_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.master-sg.id, aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.private-subnet-1.id

  user_data = base64encode(
                templatefile(
                  "${path.module}/user_data.tpl", 
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
  target_id        = aws_instance.bootstrap-machine.id
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-tg-b" {
  target_group_arn = aws_lb_target_group.int-tg.arn
  target_id        = aws_instance.bootstrap-machine.id
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-s-tg-b" {
  target_group_arn = aws_lb_target_group.int-s-tg.arn
  target_id        = aws_instance.bootstrap-machine.id
  // port             = 80
}
