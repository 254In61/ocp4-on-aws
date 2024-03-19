// Bastion EC2 creation

resource "aws_instance" "bastion" {
   ami                         = var.aws_ami
   instance_type               = var.ec2_instance_type
   subnet_id                   = var.public_subnet_id
   vpc_security_group_ids      = [var.sec_grp_id]
   key_name                    = var.key_pair
   iam_instance_profile        = var.iam_role
   associate_public_ip_address = true

   ebs_block_device {
     device_name = var.ebs_block_device_name
     volume_size = var.ebs_block_volume_size
     volume_type = var.ebs_block_volume_type
     // encrypted                 = true
     delete_on_termination = true
   }

   tags = {
     Creator     = "${var.creator}"
     Environment = "${var.env}"
     Name        = "${var.name}"
   }
 }

