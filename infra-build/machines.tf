// YES! This duplicated code will be fixed with Terragrunt!

// 1. BOOTSTRAP INSTANCE

resource "aws_network_interface" "bootstrap-ni" {
  subnet_id        = aws_subnet.public-subnet-1.id
  private_ips      = ["${var.a.bootstrap_priv_ip}"]
  security_groups  = [aws_security_group.bootstrap-sg.id, aws_security_group.master-sg.id]
  description      = "Bootstrap network interface"

  tags = {
   "Name" = "${var.infra_name}-bootstrap"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

resource "aws_instance" "bootstrap" {
  ami                         = "${var.aws_rhos_ami}"
  iam_instance_profile        = aws_iam_role.BootstrapIamRole.name
  instance_type               = "${var.bootstrap_ec2_instance_type}"
  associate_public_ip_address = true
  key_name                    = "${var.ec2_key_pair}"

  network_interface {
    network_interface_id      = aws_network_interface.bootstrap-ni.id
    device_index              = 0
  }

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

// Register with NLB Target Group



// 2. MASTER INSTANCES

// 2.1 : master 0

resource "aws_instance" "master-0" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-0"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 2.2 : master 1

resource "aws_instance" "master-1" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-1"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}

// 2.3 : master 2

resource "aws_instance" "master-2" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.master_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-master-2"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}



// 3. WORKER INSTANCES

// 3.1 : worker 0

resource "aws_instance" "worker-0" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.worker_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-worker-${var.region}a"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}


// 3.2 : worker 1

resource "aws_instance" "worker-1" {
  ami           = "${var.aws_rhos_ami}"
  instance_type = "${var.worker_ec2_instance_type}"

  tags = {
   "Name" = "${var.infra_name}-worker-${var.region}b"
   "kubernetes.io/cluster/${var.infra_name}" = "owned"
  }
}
