variable "owner_name" {
  type = "string"
  description = "Designated Owner of Bastion Hosts"
}

variable "subnet_ids" {
  type = "list"
  description = "Bastion Autoscaling Group will place hosts in these subnets."
}

variable "lb_subnet_ids" {
  type = "list"
  description = "Bastion Load Balancer will operate in these subnets."
}

variable "project_name" {
  type = "string"
  description = "Designated Project for Bastion Hosts"
}

variable "key_name" {
  type = "string"
  description = "SSH Key Pair Name"
}

variable "vpc_id" {
  type = "string"
  description = "VPC ID"
}

variable "security_group_ids" {
  type = "list"
  description = "Security Group for Bastion Hosts"
}

variable "lb_security_group_ids" {
  type = "list"
  description = "Security Group for Load Balancer"
}

variable "project_domain" {
  type = "string"
  description = "Route53 Domain Name"
}

variable "volume_size" {
  type = "string"
  default = "20"
  description = "Root Volume Size for Bastion Host"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
  description = "Instance type for Bastion Host"
}
