# Create a simple AWS network with remote backend

module "backend" {
  source = "../../modules/backend"

  bucket-name         = "ndo-dev-terraform-state"
  dynamodb-table-name = "ndo-dev-terraform-locks"
}