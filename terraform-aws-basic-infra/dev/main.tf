# Build a basic AWS network with an EC2 instance running minikube

terraform {
  backend "s3" {
    bucket         = "ndo-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ndo-dev-terraform-locks"
  }
}

module "network" {
  source = "github.com/jakefurlong/terraform/modules/network"

  vpc_cidr              = "172.16.0.0/16"
  env                   = "Development"
  public-subnet-cidr-a  = "172.16.0.0/24"
  public-subnet-cidr-b  = "172.16.1.0/24"
  public-subnet-cidr-c  = "172.16.2.0/24"
  private-subnet-cidr-a = "172.16.3.0/24"
  private-subnet-cidr-b = "172.16.4.0/24"
  private-subnet-cidr-c = "172.16.5.0/24"
  my-ip                 = "174.51.57.8"
}