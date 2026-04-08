#Private Hosted Zones
resource "aws_route53_zone" "cinnabun" {
  name = "cinnabun.com"
  vpc {
    vpc_id = aws_vpc.np.id
  }
  vpc {
    vpc_id = aws_vpc.prd.id
  }
}

resource "aws_route53_record" "cbdlapp01" {
  zone_id = aws_route53_zone.cinnabun.zone_id
  name    = "cbdlapp01"
  type    = "A"
  ttl     = 300
  records = ["10.0.1.10"]
}