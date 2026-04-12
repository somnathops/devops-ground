module "vpc" {
    source = "../../modules/vpc"
    environment_name = var.environment_name
    region = var.region
    vpc_cidr = var.vpc_cidr
    num_azs = var.num_azs
    single_nat_gateway = var.single_nat_gateway
    enable_flow_logs = var.enable_flow_logs
    tags = var.tags
  
}