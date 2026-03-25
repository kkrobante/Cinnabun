terraform {
	required_providers {
		aws = {
      			source  = "hashicorp/aws"
    		}
  	}

    backend "s3" {
    bucket = "terraform-states-972588015379-us-east-1-an"
    key    = "CinnabunProject/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    }
}

