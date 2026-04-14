output "cluster_name" {
    description = "EKS cluster name"
    value       = aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
    description = "EKS cluster API endpoint"
    value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_ca_certificate" {
    description = "EKS cluster certificate authority"
    value       = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "node_group_id" {
    description = "EKS node group ID"
    value       = aws_eks_node_group.nodes.id
}