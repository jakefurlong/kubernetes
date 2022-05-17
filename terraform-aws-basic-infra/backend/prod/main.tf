# Create remote backend resources in AWS

module "backend" {
  source = "github.com/jakefurlong/terraform/modules/backend"

  bucket-name         = "ndo-prod-terraform-state"
  dynamodb-table-name = "ndo-prod-terraform-locks"
  aws-region          = "us-east-1"
}
