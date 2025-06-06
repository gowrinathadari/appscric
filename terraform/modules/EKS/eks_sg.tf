#Security Groups for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-cluster-sg"
    
  }

}
resource "aws_security_group_rule" "appscric-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster_sg.id
  to_port           = 443
  type              = "ingress"
}

# Security Groups for EKS Nodes
resource "aws_security_group" "appscric_node" {
  name        = "appscrip-eks-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = tomap({
     "Name" = "appscrip-eks-node",
     
  })
}

resource "aws_security_group_rule" "appscric-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.appscric_node.id
  source_security_group_id = aws_security_group.appscric_node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "repute-node-ingress-ssh" {
  description              = "Allow node for ssh"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.appscric_node.id
  source_security_group_id = aws_security_group.appscric_node.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "repute-node-ingress-ssh-vpc" {
  description              = "Allow eks node for ssh "
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.appscric_node.id
  cidr_blocks              = ["10.0.0.0/16"]
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "repute-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.appscric_node.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
  to_port                  = 65535
  type                     = "ingress"
}