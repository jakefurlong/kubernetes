# Build a basic AWS network with an EC2 instance running minikube

terraform {
  backend "s3" {
    bucket         = "ndo-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ndo-dev-terraform-locks"
  }
}