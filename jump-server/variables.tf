/*
- Variables file
- All variables are defined here.
*/

# === BACKEND ====
variable "tfstate_backend_s3_bucket_name" {
  description = "S3_bucket_name"
  default     = "<S3 bucket name acting as your backend>"
}

# === COMMON ====
variable "ec2_instance_type"{
  description = "EC2 instance type"
  default = "t3.2xlarge"  // Trying bigger capacity, to see if install can be faster
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "<Your region>"
}

# == NETWORK ===
variable "vpc_id" {
  default     = "vpc-0929eedabfc80e2a8"
  description = "ocpv4 on aws vpc"
}

variable "public_subnet_a_id" {
  default     = "subnet-0c903ca08687e2f60"
  description = "Public subnet AZ A"
}

# === SECURITY ===
variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "<your AWS key pair>"
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
  default     = "30"  // Free tier eligible customers can get up to 30 GB of EBS General Purpose (SSD) or Magnetic storage
}

variable "ebs_block_device_name" {
  description = "Device name"
  default     = "/dev/xvda"
}

# === IAM ROLE ===

variable "iam_role"{
  description  = "IAM role to attach to instance"
  default      = "<your IAM role name>"  // IAM role that permits Session Manager
}

# === TAGS ===

variable "tag_creator" {
  description = "Creator Tag"
  default     = "<Your names here>"
}

variable "tag_env" {
  description = "Environment"
  default     = "ocpv4-lab"
}

variable "tag_function" {
  description = "Function"
  default     = "OCPV4 install jump server"
}

variable "tag_name"{
  description = "Name"
  default     = "ocpv4-jump-server"
}

