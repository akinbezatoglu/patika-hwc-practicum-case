# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = var.region
  access_key = var.auth_accesskey
  secret_key = var.auth_secretkey
}