// YES! This duplicated code will be fixed with Terragrunt!

// 1. BOOTSTRAP INSTANCE

/*
resource "aws_network_interface" "bootstrap-ni" {
  subnet_id                   = aws_subnet.public-subnet-1.id
  // private_ips              = ["${var.bootstrap_priv_ip}"]
  security_groups             = [aws_security_group.bootstrap-sg.id, aws_security_group.master-sg.id]
  description                 = "Bootstrap network interface"
  

  tags = {
   "Name" = "${var.infra_name}-bootstrap"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}
*/

resource "aws_instance" "bootstrap-machine" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_role.BootstrapIamRole.name
  instance_type               = "${var.bootstrap_ec2_instance_type}"
  key_name                    = "${var.ec2_key_pair}"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.bootstrap-sg.id, aws_security_group.master-sg.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  
  /*
  network_interface {
    network_interface_id      = aws_network_interface.bootstrap-ni.id
    device_index              = 0
  }
  */

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

/*
resource "aws_network_interface_attachment" "bootstrap-ni-attach" {
  instance_id          = aws_instance.bootstrap-machine.id
  network_interface_id = aws_network_interface.bootstrap-ni.id
  device_index         = 0
}
*/

