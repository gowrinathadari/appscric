resource "aws_eks_node_group" "appscric_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "appscric-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.pvt_subnet_ids
  instance_types = ["t3.medium"] 
  capacity_type = "ON_DEMAND"
  ami_type = "AL2023_x86_64_STANDARD" # Amazon Linux 2 AMI for EKS

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 2
  }
 

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
    
  ]
  
}
resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = aws_eks_cluster.appscric.name
  addon_name   = "vpc-cni"
}
resource "aws_eks_addon" "coredns_addon" {
  cluster_name = aws_eks_cluster.appscric.name
  addon_name   = "coredns"
  
}
resource "aws_eks_addon" "kube_proxy_addon" {
  cluster_name = aws_eks_cluster.appscric.name
  addon_name   = "kube-proxy"
  
}
resource "aws_eks_addon" "ebs_csi_addon" {
  cluster_name = aws_eks_cluster.appscric.name
  addon_name   = "aws-ebs-csi-driver"
  
}
resource "aws_eks_addon" "metrics_server_addon" {
  cluster_name = aws_eks_cluster.appscric.name
  addon_name   = "metrics-server"
}