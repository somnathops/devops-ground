output "vpc_id" {
    description = "VPC ID"
    value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
    description = "Public subnet IDs"
    value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
    description = "Private subnet IDs"
    value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
    description = "NAT Gateway IDs"
    value       = module.vpc.nat_gateway_ids
}

output "cluster_name" {
    description = "EKS cluster name"
    value       = module.eks.cluster_name
}

output "cluster_endpoint" {
    description = "EKS cluster endpoint"
    value       = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
    description = "EKS cluster CA certificate"
    value       = module.eks.cluster_ca_certificate
}