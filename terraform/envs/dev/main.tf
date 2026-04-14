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

module "eks" {
    source = "../../modules/eks"
    environment_name = var.environment_name
    region = var.region
    cluster_name = var.cluster_name
    kubernetes_version = var.kubernetes_version
    instance_type = var.instance_type
    desired_nodes = var.desired_nodes
    max_nodes = var.max_nodes
    min_nodes = var.min_nodes
    vpc_state_bucket = var.vpc_state_bucket
    vpc_state_key = var.vpc_state_key
    tags = var.tags
    
}