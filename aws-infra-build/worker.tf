// YES! This duplicated code will be fixed with Terragrunt!

resource "aws_iam_instance_profile" "worker-instance-profile" {
  name = "${var.infra_name}-worker-instance-profile"
  role = aws_iam_role.WorkerIamRole.name

  tags = {
   "Name" = "${var.infra_name}-worker-instance-profile"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// worker 1

resource "aws_instance" "worker-1" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.worker-instance-profile.name
  instance_type               = "${var.worker_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.worker-sg.id]
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
                  "${path.module}/worker-user-data.tpl", 
                  { SOURCE = "${var.worker_ignition_location}",CA_BUNDLE = "${var.certificate_authorities}" }
                )
              )

  tags = {
   "Name" = "${var.infra_name}-worker-1"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}


// worker 2

resource "aws_instance" "worker-2" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_instance_profile.worker-instance-profile.name
  instance_type               = "${var.worker_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.worker-sg.id]
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
                  "${path.module}/worker-user-data.tpl", 
                  { SOURCE = "${var.worker_ignition_location}",CA_BUNDLE = "${var.certificate_authorities}" }
                )
              )

  tags = {
   "Name" = "${var.infra_name}-worker-2"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}
