variable "aws_region" {
  default = "eu-central-1"
}

variable vpc_cidr {
  type    = string
}

variable subnet_cidrs {
  type    = list(string)
}

variable map_public_ip_on_launch {
  type    = bool 
}

variable cluster_name {
  type    = string
}

variable node_group_name {
  type    = string
}

variable sc_desired_size {
  type    = number
}

variable sc_max_size {
  type    = number
}

variable sc_min_size {
  type    = number
}

variable instance_types {
  type    = list(string)
}

variable capacity_type {
  type    = string
}

variable security_groups {}