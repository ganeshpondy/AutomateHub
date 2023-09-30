provider "aws" {
  region  = var.region
  alias   = "default"
  profile = "default" # add User profile name here
}

# provider "aws" {
#   region  = "us-east-1"
#   alias   = "useast1"
#   profile = "default"
# }
