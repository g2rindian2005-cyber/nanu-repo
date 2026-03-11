
# Dev Account Provider
provider "aws" {
  alias   = "dev"
  region  = var.region
  profile = "dev"
}

# Test Account Provider
provider "aws" {
  alias   = "test"
  region  = var.region
  profile = "test"
}