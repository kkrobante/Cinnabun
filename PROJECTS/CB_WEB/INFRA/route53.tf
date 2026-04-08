resource "aws_route53_zone" "cinnabun" {
  name = "cinnabun.com"
}

resource "aws_route53_record" "cbdlapp01" {
  zone_id = aws_route53_zone.cinnabun.zone_id
  name    = "cbdlapp01.cinnabun.com"
  type    = "A"
  ttl     = 300
  records = ["10.0.101.10"]
}

resource "aws_route53_record" "cname_record" {
  zone_id = aws_route53_zone.cinnabun.zone_id
  name    = "cbdlapp.cinnabun.com"
  type    = "CNAME"
  ttl     = 300
  records = ["cbdlapp01.cinnabun.com"]
}