#Private Hosted Zones
resource "aws_route53_zone" "np" {
  name = "nonprod"
  vpc {
    vpc_id = aws_vpc.np.id
  }
}

resource "aws_route53_record" "cbdlapp01" {
  zone_id = aws_route53_zone.np.zone_id
  name    = "cbdlapp01.cinnabun.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.1.10"]
}