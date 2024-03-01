// jump-server

resource "aws_instance" "jump-server" {
   ami                         = var.ocpv4_jump_server_ami
   instance_type               = var.ec2_instance_type
   subnet_id                   = var.public_subnet_a_id
   vpc_security_group_ids      = ["${aws_security_group.ocpv4_lab_sg.id}"]
   key_name                    = var.key_name
   associate_public_ip_address = true
   iam_instance_profile        = var.iam_role

   ebs_block_device {
     device_name = var.ebs_block_device_name
     volume_size = var.ebs_block_volume_size
     volume_type = var.ebs_block_volume_type
     // encrypted                 = true
     delete_on_termination = true
   }


   tags = {
     Creator     = "${var.tag_creator}"
     Environment = "${var.tag_env}"
     Function    = "${var.tag_function}"
     Name        = "${var.tag_name}"
   }
}

