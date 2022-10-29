terraform {
  required_version = ">= 0.13"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}

provider "huaweicloud" {
  access_key = var.auth_accesskey
  secret_key = var.auth_secretkey
  region     = var.region
}
