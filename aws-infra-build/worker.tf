// YES! This duplicated code will be fixed with Terragrunt!

// WORKER INSTANCES

/*

// worker 0

resource "aws_instance" "worker-0" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.worker_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-worker-${var.region}a"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}


// worker 1

resource "aws_instance" "worker-1" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.worker_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-worker-${var.region}b"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

*/