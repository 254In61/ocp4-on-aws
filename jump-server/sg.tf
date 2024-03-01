# # Security groups resources

# Sec group to use for Jump Server
# This is for LAB only. In deployment, it should be more specific,

resource "aws_security_group" "ocpv4_lab_sg" {
  name   = "lab_sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Creator     = "${var.tag_creator}"
    Environment = "${var.tag_env}"
    Function    = "${var.tag_function}"
    Name        = "ocpv4-lab-sg"
  }
}

