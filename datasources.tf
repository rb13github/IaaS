data "aws_caller_identity" "current" {}

data "aws_vpc" "mainp" {
  id = "vpc-00c4970b9f56846cc"
}

data "aws_subnet" "mainp_a" {
  id = "subnet-0482234cddef5a0f8"
}