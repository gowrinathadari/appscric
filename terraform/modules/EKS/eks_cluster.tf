resource "aws_eks_cluster" "appscric" {
    name = var.eks_cluster_name
    role_arn = aws_iam_role.eks_cluster_admin_role.arn
    version = "1.32"
    vpc_config {
        subnet_ids = var.pvt_subnet_ids
        security_group_ids = [aws_security_group.eks_cluster_sg.id]
    }
    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
        aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
    ]
   


}
           
        
    

  
