variable "aws_region" {
default = "us-east-1"
}

variable "rhel_ami" {
default = "ami-0ad50334604831820"
}
 
variable "vpc_cidr" {
default = "10.0.0.0/16"
}

variable "subnet_public-a" {
default = "10.0.1.0/24"
}

variable "subnet_public-b" {
default = "10.0.2.0/24"
}

variable "subnet_private-a" {
default = "10.0.101.0/24"
}
variable "subnet_private-b" {
default = "10.0.102.0/24"
}

variable "instance_type" {
default = "t3.micro"
}

variable "key_pair" {
  description = "Existing AWS key pair name"
}

variable "db_name" {
  default = "mydatabase"
}

variable "db_username" {
  default = "admin123"
}

variable "db_password" {
  default = "admin123"
}
variable "common_tags" {
description = "Common tags applied to all resources"
  type        = map(string)
}
