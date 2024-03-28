// YES! This duplicated code will be fixed with Terragrunt!

resource "aws_iam_instance_profile" "master-instance-profile" {
  name = "${var.infra_name}-master-instance-profile"
  role = aws_iam_role.MasterIamRole.name

  tags = {
   "Name" = "${var.infra_name}-master-instance-profile"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// Master 1

resource "aws_instance" "master-1" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.master-instance-profile.name
  instance_type               = "${var.master_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.private-subnet-1.id

  ebs_block_device {
     device_name = "${var.ebs_block.device_name}"
     volume_size = "${var.ebs_block.volume_size}"
     volume_type = "${var.ebs_block.volume_type}"
     // encrypted                 = true
     delete_on_termination = true
  }

  user_data = base64encode(
                templatefile(
                  "${path.module}/master-user-data.tpl", 
                  { SOURCE = "${var.master_ignition_location}",CA_BUNDLE = "${var.certificate_authorities}" }
                )
              )

  tags = {
   "Name" = "${var.infra_name}-master-1"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// Register machine as a Target to LB Target groups

resource "aws_lb_target_group_attachment" "ext-tg-m-1" {
  target_group_arn = aws_lb_target_group.ext-tg.arn
  target_id        = aws_instance.master-1.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-tg-m-1" {
  target_group_arn = aws_lb_target_group.int-tg.arn
  target_id        = aws_instance.master-1.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-s-tg-m-1" {
  target_group_arn = aws_lb_target_group.int-s-tg.arn
  target_id        = aws_instance.master-1.private_ip
  // port             = 80
}

// Master 2

resource "aws_instance" "master-2" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.master-instance-profile.name
  instance_type               = "${var.master_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.private-subnet-2.id

  ebs_block_device {
     device_name = "${var.ebs_block.device_name}"
     volume_size = "${var.ebs_block.volume_size}"
     volume_type = "${var.ebs_block.volume_type}"
     // encrypted                 = true
     delete_on_termination = true
  }

  user_data = base64encode(
                templatefile(
                  "${path.module}/master-user-data.tpl", 
                  { SOURCE = "${var.master_ignition_location}",CA_BUNDLE = "${var.certificate_authorities}" }
                )
              )

  tags = {
   "Name" = "${var.infra_name}-master-2"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// Register machine as a Target to LB Target groups

resource "aws_lb_target_group_attachment" "ext-tg-m-2" {
  target_group_arn = aws_lb_target_group.ext-tg.arn
  target_id        = aws_instance.master-2.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-tg-m-2" {
  target_group_arn = aws_lb_target_group.int-tg.arn
  target_id        = aws_instance.master-2.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-s-tg-m-2" {
  target_group_arn = aws_lb_target_group.int-s-tg.arn
  target_id        = aws_instance.master-2.private_ip
  // port             = 80
}

// Master 3

resource "aws_instance" "master-3" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.master-instance-profile.name
  instance_type               = "${var.master_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.private-subnet-3.id

  ebs_block_device {
     device_name = "${var.ebs_block.device_name}"
     volume_size = "${var.ebs_block.volume_size}"
     volume_type = "${var.ebs_block.volume_type}"
     // encrypted                 = true
     delete_on_termination = true
  }

  user_data = base64encode(
                templatefile(
                  "${path.module}/master-user-data.tpl", 
                  { SOURCE = "${var.master_ignition_location}",CA_BUNDLE = "${var.certificate_authorities}" }
                )
              )

  tags = {
   "Name" = "${var.infra_name}-master-3"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// Register machine as a Target to LB Target groups

resource "aws_lb_target_group_attachment" "ext-tg-m-3" {
  target_group_arn = aws_lb_target_group.ext-tg.arn
  target_id        = aws_instance.master-3.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-tg-m-3" {
  target_group_arn = aws_lb_target_group.int-tg.arn
  target_id        = aws_instance.master-3.private_ip
  // port             = 80
}

resource "aws_lb_target_group_attachment" "int-s-tg-m-3" {
  target_group_arn = aws_lb_target_group.int-s-tg.arn
  target_id        = aws_instance.master-3.private_ip
  // port             = 80
}
