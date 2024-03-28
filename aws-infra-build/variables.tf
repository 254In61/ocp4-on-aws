// YES!! LOTS OF REPITITION HERE!! Terragrunt is the magic bullet!

// COMMON
variable "infra_name"{
  description = "Obtained by running : $ jq -r .infraID ~/metadata.json"
  type        = string
}

variable "region"{
  description  = "AWS region"
  type         = string
}

variable "cluster_name"{
  description  = "Chose cluster name"
  type         = string
}

// VPC
variable "vpc_cidr"{
  description  = "VPC cidr"
  type         = string
}

// SUBNETS
// Map defined in terrafor.tfvars file

variable "a" {
   description = "Availability zone A"
   type        = map
}

variable "b" {
   description = "Availability zone B"
   type        = map
}


variable "c" {
   description = "Availability zone C"
   type        = map
}


// DNS

variable "hosted_zone_name"{
   description = "Hosted zone domain"
   type        = string
}
variable "hosted_zone_id"{
   description = "Public Hosted Zone ID"
   type        = string
}

// MACHINE DETAILS

variable "aws_rhos_ami"{
   description = "RHOS AWS AMI used"
   type        = string
}

variable "bootstrap_ec2_instance_type"{
   description = "Worker ec2 instance type"
   type        = string
}

variable "master_ec2_instance_type"{
   description = "Worker ec2 instance type"
   type        = string
}

variable "worker_ec2_instance_type"{
   description = "Worker ec2 instance type"
   type        = string
}

variable "aws_machine_arch"{
   description = "Machine architecture type"
   type        = string
}

// Ignition files location

variable "bootstrap_ignition_location"{
   description = "URL for s3 stored bootstrap ignition file"
   type        = string
}

variable "master_ignition_location"{
   description = "URL for master ignition file"
   type        = string
}

variable "worker_ignition_location"{
   description = "URL for worker ignition file"
   type        = string
}


// Key pair 
variable "ec2_key_pair"{
   description = " EC2 key pair"
   type        = string
}

// Storage blocks
variable "ebs_block"{
   description = "Ebs block device details"
   type        = map
}

// Certificate authorities
variable "certificate_authorities"{
   description = "Base64 encoded certificate authority string to use."
   type        = string
}