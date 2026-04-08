#Private Hosted Zones
resource "aws_route53_zone" "prd" {
  name = "prod"
  vpc {
    vpc_id = aws_vpc.prd.id
  }
}