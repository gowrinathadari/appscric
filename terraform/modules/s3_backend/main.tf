#create s3 bucket for remot bacend
resource "aws_s3_bucket" "appscric_bucket" {
    bucket = var.aws_s3_bucket 
}


#create Dynamodb table
resource "aws_dynamodb_table" "terraform_lock" {
  name           = var.name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key

  attribute {
    name = "LockID"
    type = "S" #it is a string
  }
}