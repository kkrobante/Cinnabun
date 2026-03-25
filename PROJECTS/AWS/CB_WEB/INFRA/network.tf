# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
        Name = "TF-Cinnabun-vpc"
        }
}

# Subnet
resource "aws_subnet" "private-a" {
        vpc_id          = aws_vpc.main.id
        cidr_block      = var.subnet_private-a
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "private subnet"
        }
}
resource "aws_subnet" "private-b" {
        vpc_id          = aws_vpc.main.id
        cidr_block      = var.subnet_private-b
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "private subnet"
        }
}

resource "aws_subnet" "public-a" {
        vpc_id          = aws_vpc.main.id
        cidr_block      = var.subnet_public-a
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "public subnet"
        }
}
resource "aws_subnet" "public-b" {
        vpc_id          = aws_vpc.main.id
        cidr_block      = var.subnet_public-b
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "public subnet"
        }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "RDS" {
  name       = "postgres-subnet-group"
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "TF-CBD-igw"
  }
}

# Route Table
resource "aws_route_table" "public-a" {
  vpc_id = aws_vpc.main.id
  tags = {
        Name = "public"
        }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route Table Association
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-a.id
}

# Security Group
resource "aws_security_group" "CBD" {
  name   = "TF-CBD-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

