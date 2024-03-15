/*
- Variables file
- All variables are defined here.
*/

variable "tfstate_backend_s3_bucket_name" {
  description = "S3_bucket_name"
  default     = "tfstate-backend-store" // Key in your S3 backend
}

variable "ec2_instance_type"{
  description = "EC2 instance type"
  default = "t3.2xlarge"  // Bigger capacity == Faster install
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-southeast-2" // Key in your region
}

# == NETWORK ===
// Find these variables under cloudformation >> the-vpc-stack-created >> Outputs

variable "vpc_id" {
  default     = "vpc-09efffd26b9b89216"
  description = "ocpv4 on aws vpc"
}

variable "public_subnet_a_id" {
  default     = "subnet-0f66b62e3e22ea8c5"
  description = "Public subnet AZ A"
}

# === SECURITY ===
variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "ocpv4-on-aws-key-pair"
}

# === AMIs ====
variable "ocpv4_jump_server_ami" {
  description = "Amazon Machine Image"
  default     = "ami-04f5097681773b989" // Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-12-07
}

# === STORAGE ==
variable "ebs_block_volume_type" {
  description = "Device name"
  default     = "gp2"
}

variable "ebs_block_volume_size" {
  description = "Root block volume"
  default     = "30"
}

variable "ebs_block_device_name" {
  description = "Device name"
  default     = "/dev/xvda"
}

# === IAM ROLE ===

variable "iam_role"{
  description  = "IAM role to attach to instance"
  default      = "Ec2SSMRole"  // IAM role that permits Session Manager
}

# === TAGS ===

variable "env" {
  description = "Environment"
  default     = "ocpv4-dev-lab"
}


