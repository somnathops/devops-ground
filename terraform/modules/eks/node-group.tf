resource "aws_eks_node_group" "nodes" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "${var.cluster_name}-node-group"
    node_role_arn = aws_iam_role.node_role.arn
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
    instance_types = [var.instance_type]
    version = var.kubernetes_version
    scaling_config {
        desired_size = var.desired_nodes
        max_size = var.max_nodes
        min_size = var.min_nodes
    }
    depends_on = [
        aws_iam_role_policy_attachment.node_policy,
        aws_iam_role_policy_attachment.ecr_policy,
        aws_iam_role_policy_attachment.cni_policy
    ]
    tags = merge(var.tags, {
        "Name" = "${var.cluster_name}-node-group"
    })
}