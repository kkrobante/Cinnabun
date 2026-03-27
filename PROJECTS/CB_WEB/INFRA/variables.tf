variable "aws_region" {
default = "us-east-1"
}

variable "rhel_ami" {
default = "ami-0ad50334604831820"
}
 
variable "instance_type" {
default = "t3.micro"
}

variable "key_pair" {
  description = "Existing AWS key pair name"
}

variable "common_tags" {
description = "Common tags applied to all resources"
  type        = map(string)
}
