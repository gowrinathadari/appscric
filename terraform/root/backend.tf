terraform {
  backend "s3" {
    bucket         = "appscric-terraform-backend-bucket"
    key            = "gowrinath/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        =  true
    dynamodb_table = "terraform-lock"
  }
}