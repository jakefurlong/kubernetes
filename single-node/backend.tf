terraform {
  backend "s3" {
    bucket         = "kubernimbus-state"
    key            = "global/s3/single-node/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kubernimbus-single-node-locks"
    encrypt        = true
  }
}