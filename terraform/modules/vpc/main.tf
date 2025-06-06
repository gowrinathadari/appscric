terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
# attach the Internet Gateway to the VPC
resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id             = aws_vpc.vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
  
}

resource "aws_subnet" "pub_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Public-Subnet-1"
  }
}
resource "aws_subnet" "pub_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Public-Subnet-2"
  }
}
resource "aws_subnet" "pub_subnet_3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_3_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1c"     
    tags = {
        Name = "Public-Subnet 3"
    }
}
# Create a route table for the public subnets
resource "aws_route_table" "public_RouteTable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}
# Associate the route table with the public subnets
resource "aws_route_table_association" "pub_subnet_1_association" { 
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.public_RouteTable.id
}
resource "aws_route_table_association" "pub_subnet_2_association" {
  subnet_id      = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.public_RouteTable.id
}
resource "aws_route_table_association" "pub_subnet_3_association" {
  subnet_id      = aws_subnet.pub_subnet_3.id
  route_table_id = aws_route_table.public_RouteTable.id
}

# Crete private subnets
resource "aws_subnet" "priv_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block =  var.pvt_subnet_1_cidr
    availability_zone = "ap-south-1a"
    tags = {
        Name = "${var.project_name}-private-subnet-1"
    }
}
resource "aws_subnet" "priv_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet_2_cidr
  availability_zone = "ap-south-1b"
    tags = {
        Name = "${var.project_name}-private-subnet-2"
        }
}
resource "aws_subnet" "priv_subnet_3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet_3_cidr
  availability_zone = "ap-south-1c"
    tags = {
        Name = "${var.project_name}-private-subnet-3"
    }
}

#create a Elastic ip for NAT Gateway for private subnets
resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "${var.project_name}-nat-eip"
  
}
}

# Create a NAT Gateway in the first public subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_subnet_1.id   
  tags = {
        Name = "${var.project_name}-nat-gtw"
    }
  depends_on = [aws_internet_gateway.igw]
}

# Create a route table for the private subnets
resource "aws_route_table" "private_RouteTable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-Route-Table"
  }
}
# Associate the route table with the private subnets
resource "aws_route_table_association" "priv_subnet_1_association" {
  subnet_id      = aws_subnet.priv_subnet_1.id
  route_table_id = aws_route_table.private_RouteTable.id
}
resource "aws_route_table_association" "priv_subnet_2_association" {
  subnet_id      = aws_subnet.priv_subnet_2.id
  route_table_id = aws_route_table.private_RouteTable.id
}
resource "aws_route_table_association" "priv_subnet_3_association" {
  subnet_id      = aws_subnet.priv_subnet_3.id
  route_table_id = aws_route_table.private_RouteTable.id
}
