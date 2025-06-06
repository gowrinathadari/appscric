output "eks_cluster_admin_role" {
    value = aws_iam_role.eks_cluster_admin_role.name
  
}
output "endpoint" {
    value = aws_eks_cluster.appscric.endpoint
  
}
output "cluster_role_arn" {
    value = aws_iam_role.eks_cluster_admin_role.arn
  
}

output "eks_cluster_admin_policy_attachment" {
    value = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy, aws_iam_role_policy_attachment.AmazonEKSServicePolicy, aws_iam_role_policy_attachment.AmazonEKSVPCResourceController] 
  
}

output "eks_node_role" {
    value = aws_iam_role.eks_node_role.name
  
}

output "eks_node_role_arn" {
    value = aws_iam_role.eks_node_role.arn
  
}
output "eks_node_group_policy" {
    value = [aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy, aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly]
  
}
