// SUBNETS
// Map defined in terrafor.tfvars file

variable "cluster_vpc_subnets" {
   type = map(object({
   cidr = string
   az   = string
 }))

 description = "Subnets for the cluster vpc"
}

