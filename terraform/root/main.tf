module "vpc" {
  source = "../modules/vpc"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  pub_subnet_1_cidr = var.pub_subnet_1_cidr
  pub_subnet_2_cidr = var.pub_subnet_2_cidr
  pub_subnet_3_cidr = var.pub_subnet_3_cidr
  pvt_subnet_1_cidr = var.pvt_subnet_1_cidr
  pvt_subnet_2_cidr = var.pvt_subnet_2_cidr
  pvt_subnet_3_cidr = var.pvt_subnet_3_cidr

}

module "EKS" {
  source = "../modules/EKS"
  eks_node_role = var.eks_node_role
  eks_admin = var.eks_admin
  vpc_id = module.vpc.vpc_id
  eks_cluster_sg = module.vpc.vpc_id
  eks_cluster_name = var.eks_cluster_name
  pvt_subnet_ids = module.vpc.pvt_subnet_ids
  
  
  
  
}

module "route53" {
  source = "../modules/route53"
  
  
}

module "s3_backend" {
    source = "../modules/s3_backend"
    aws_s3_bucket = var.aws_s3_bucket
    name = var.name
    billing_mode = var.billing_mode
    hash_key = var.hash_key
}