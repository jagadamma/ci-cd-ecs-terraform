terraform {
  backend "s3" {
    bucket = "posistrength-dev-terraform-statefiless"

    key     = "posistrength/dev/state/ap-south-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

