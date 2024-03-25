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