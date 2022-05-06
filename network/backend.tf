terraform {
  backend "s3" {
    bucket         = "kubernimbus-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kubernimbus-locks"
    encrypt        = true
  }
}