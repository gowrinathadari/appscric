# Create the Kubernetes provider
provider "kubernetes" {
  host                   = aws_eks_cluster.appscric.endpoint
  token                  = data.aws_eks_cluster_auth.appscric.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.appscric.certificate_authority[0].data)
  
  
}

data "aws_eks_cluster_auth" "appscric" {
  name = aws_eks_cluster.appscric.name
}



# Use locals with account ID variable
locals {
  aws_auth_configmap = <<EOF
- rolearn: "${aws_iam_role.eks_node_role.arn}"
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes

- userarn: "arn:aws:iam::506334646887:root
  groups:
    - system:masters

EOF
}

# Create the aws-auth ConfigMap
resource "kubernetes_config_map" "appscric" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = local.aws_auth_configmap
  }
  lifecycle {
    ignore_changes = [data.mapRoles]
  }
}