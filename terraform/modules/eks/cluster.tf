resource "aws_eks_cluster" "cluster" {
    name = var.cluster_name
    version = var.kubernetes_version
    role_arn = aws_iam_role.cluster_role.arn
    vpc_config {
      subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
    }
    depends_on = [ 
        aws_iam_role_policy_attachment.cluster_policy
    ]
    tags = merge(var.tags, {
        "Environment" = var.environment_name
    })
  
}