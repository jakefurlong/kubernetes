# Create a simple AWS network with remote backend

module "backend" {
  source = "../modules/backend"

  bucket-name         = "ndo-prod-terraform-state"
  dynamodb-table-name = "ndo-prod-terraform-locks"
}