# Create remote backend resources in AWS

module "backend" {
  source = "github.com/jakefurlong/terraform/modules/backend"

  bucket-name         = "ndo-test-terraform-state"
  dynamodb-table-name = "ndo-test-terraform-locks"
  aws-region          = "us-east-1"
}