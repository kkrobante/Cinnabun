###Cinnabun WebApp EC2 Instance
resource "aws_instance" "cbdlapp01" {
  ami                    = var.rhel_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
        primary_network_interface {
                network_interface_id = aws_network_interface.cbdlapp01_p.id
        }
  user_data = file("user_data.sh")

  tags = merge(
        var.common_tags,
                {
                Name = "cbdlapp01"
                Environment = "dev"
                }
        )
}
resource "aws_network_interface" "cbdlapp01_p" {
  subnet_id = aws_subnet.private-a.id
  security_groups = [aws_security_group.CBD.id]
}

resource "aws_network_interface" "cbdlapp01_s" {
  subnet_id = aws_subnet.public-a.id
}
resource "aws_network_interface_attachment" "cbdlapp01_s_attach" {
  instance_id          = aws_instance.cbdlapp01.id
  network_interface_id = aws_network_interface.cbdlapp01_s.id
  device_index         = 1
}
