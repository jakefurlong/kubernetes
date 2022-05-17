# Create remote backend resources in AWS

module "backend" {
  source = "github.com/jakefurlong/terraform/modules/backend"

  bucket-name         = "ndo-dev-terraform-state"
  dynamodb-table-name = "ndo-dev-terraform-locks"
  aws-region          = "us-east-1"
}