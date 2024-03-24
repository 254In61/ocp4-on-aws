// COMMON
// Defined on the CLI
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


// SUBNETS
// Map defined in terrafor.tfvars file

/*
variable "cluster_vpc_subnets" {
   type = map(object({
   cidr = string
   az   = string
 }))

 description = "Subnets for the cluster vpc"
}

- Tempting to build like this! But how do I get the subnet IDs down the line?
- Will make my life hard!

*/

variable "public_subnet_1" {
   description = "Public subnet 1"
   type        = map
}

variable "private_subnet_1" {
   description = "Private subnet 1"
   type        = map
}