#################
### VPC
#################

vpc_cidr                    = "10.3.0.0/16"
subnet_cidrs                = ["10.3.0.0/24", "10.3.1.0/24"]
map_public_ip_on_launch     = true

#################
### EKS
#################

cluster_name                = "tamedia-cluster"
node_group_name             = "node-group-1"
sc_desired_size             = 2
sc_max_size                 = 2
sc_min_size                 = 1
instance_types              = ["t3.medium"]
capacity_type               = "ON_DEMAND"

#################
### Security
#################

security_groups             =  {
    public = {
      name        = "public_sg"
      description = "Security Group for Public Access"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        https = {
          from        = 443
          to          = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
}