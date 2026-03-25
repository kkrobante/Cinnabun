output "cbdlapp01_public_ip" {
  value = aws_instance.cbdlapp01.public_ip
}

output "cbdlapp01_instance_id" {
  value = aws_instance.cbdlapp01.id
}
