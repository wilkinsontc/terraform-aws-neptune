terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=2.0,<7.0"
    }
  }
  required_version = ">= 0.13,< 2.0"
}
