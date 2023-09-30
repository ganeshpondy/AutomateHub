terraform {
  backend "s3" {
    bucket         = "balavg-terraform-backend"
    key            = "week3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
