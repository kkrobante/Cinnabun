# VPC
resource "aws_vpc" "np" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
        Name = "TF-Cinnabun-Non-Prod"
        }
}

# Subnet
resource "aws_subnet" "private-a-np" {
        vpc_id          = aws_vpc.np.id
        cidr_block      = "10.0.1.0/24"
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "private subnet A np"
        }
}
resource "aws_subnet" "private-b-np" {
        vpc_id          = aws_vpc.np.id
        cidr_block      = "10.0.2.0/24"
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "private subnet B np"
        }
}

resource "aws_subnet" "public-a-np" {
        vpc_id          = aws_vpc.np.id
        cidr_block      = "10.0.101.0/24"
	availability_zone = data.aws_availability_zones.available.names[0]
        tags = {
                Name = "public subnet A np"
        }
}
resource "aws_subnet" "public-b-np" {
        vpc_id          = aws_vpc.np.id
        cidr_block      = "10.0.102.0/24"
	availability_zone = data.aws_availability_zones.available.names[1]
        tags = {
                Name = "public subnet B np"
        }
}

# Internet Gateway
resource "aws_internet_gateway" "TF-CB-igw" {
  vpc_id = aws_vpc.np.id

  tags = {
    Name = "TF-CB-igw"
  }
}

# Route Table
resource "aws_route_table" "public-entry" {
  vpc_id = aws_vpc.np.id
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
  subnet_id      = aws_subnet.public-a-np.id
  route_table_id = aws_route_table.public-entry.id
}


