variable "vpc_cidr" {
  type = string
}

variable "subnets_cidrs" {
  type = list(any)
}

variable "max_subnets" {
  type = number
}

variable "map_public_ip_on_launch" {}
