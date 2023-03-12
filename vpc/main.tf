resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.custom_vpc.id

}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnets_cidrs)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnets_cidrs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


