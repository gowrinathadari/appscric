output "vpc_id" {
    value = aws_vpc.vpc.id
  
}

output "project_name" {
    value = var.project_name
  
}
output "vpc_cidr" {
    value = var.vpc_cidr
  
}
output "pub_subnet_ids" {   
    value = [aws_subnet.pub_subnet_1.id, aws_subnet.pub_subnet_2.id, aws_subnet.pub_subnet_3.id]
  
}
output "pvt_subnet_ids" {
    value = [aws_subnet.priv_subnet_1.id, aws_subnet.priv_subnet_2.id, aws_subnet.priv_subnet_3.id]
  
}