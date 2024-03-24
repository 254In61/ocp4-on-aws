// COMMON
variable "infra_name"{
  // Obtained by running : $ jq -r .infraID ~/metadata.json
  default = "ocp4-apse2-77-sk592"
  type    = string
}

variable "region"{
  type    = string
  default = "ap-southeast-2"
}

variable "cluster_name"{
  default = "ocp4-apse2-77"
  type    = string
}


// SUBNETS
// Map defined in terrafor.tfvars file

variable "cluster_vpc_subnets" {
   type = map(object({
   cidr = string
   az   = string
 }))

 description = "Subnets for the cluster vpc"
}

