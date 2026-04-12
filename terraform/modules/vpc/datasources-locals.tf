data "aws_availability_zones" "available" {
    state = "available"  
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.num_azs)
  public_subnet_cidrs = { for k, az in local.azs : az => cidrsubnet(var.vpc_cidr, var.subnet_newbits, k)}
  private_subnet_cidrs = { for k, az in local.azs : az => cidrsubnet(var.vpc_cidr, var.subnet_newbits, k + 10)}
  nat_subnet_map = var.single_nat_gateway ? { for k, az in local.azs : az => aws_subnet.public[az].id } : { for k, az in local.azs : az => aws_subnet.public[az].id }
}