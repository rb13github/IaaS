#############
## Backend
#############

terraform {
  backend "local" {}
}

#############
## Setup provider
#############

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}