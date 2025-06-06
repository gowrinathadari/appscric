resource "aws_route53_zone" "appscric" {
  name = "cloudearn.in"
}

resource "aws_route53_zone" "dev" {
  name = "cloudearn.in"

  tags = {
    Environment = "dev"
  }
}

