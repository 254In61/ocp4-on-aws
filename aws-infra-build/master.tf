// YES! This duplicated code will be fixed with Terragrunt!
/*

// MASTER INSTANCES

// master 0

resource "aws_instance" "master-0" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-0"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// master 1
resource "aws_instance" "master-1" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-1"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// master 2

resource "aws_instance" "master-2" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-2"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

*/
