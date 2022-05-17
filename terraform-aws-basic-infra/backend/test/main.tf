# Create a simple AWS network with remote backend

module "backend" {
  source = "../../modules/backend"

  bucket-name         = "ndo-test-terraform-state"
  dynamodb-table-name = "ndo-test-terraform-locks"
}