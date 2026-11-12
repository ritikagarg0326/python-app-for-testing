
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Python-Todo-EKS"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}
