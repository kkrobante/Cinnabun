# VPC
resource "aws_vpc" "prd" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
        Name = "TF-Cinnabun-Prod"
        }
}

# Subnet
resource "aws_subnet" "private-a-prd" {
        vpc_id          = aws_vpc.prd.id
        cidr_block      = "10.0.3.0/24"
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "private subnet A prd"
        }
}
resource "aws_subnet" "private-b-prd" {
        vpc_id          = aws_vpc.prd.id
        cidr_block      = "10.0.4.0/24"
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "private subnet B prd"
        }
}

resource "aws_subnet" "public-a-prd" {
        vpc_id          = aws_vpc.prd.id
        cidr_block      = "10.0.103.0/24"
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "public subnet A prd"
        }
}
resource "aws_subnet" "public-b-prd" {
        vpc_id          = aws_vpc.prd.id
        cidr_block      = "10.0.104.0/24"
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "public subnet B prd"
        }
}

# Internet Gateway
resource "aws_internet_gateway" "TF-CB-igw" {
  vpc_id = aws_vpc.prd.id

  tags = {
    Name = "TF-CB-igw"
  }
}

# Route Table
resource "aws_route_table" "public-entry" {
  vpc_id = aws_vpc.prd.id
  tags = {
        Name = "public entry to IGW"
        }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF-CB-igw.id
  }
}

# Route Table Association
resource "aws_route_table_association" "public-entry" {
  subnet_id      = aws_subnet.public-a-prd.id
  route_table_id = aws_route_table.public-entry.id
}


