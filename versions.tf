terraform {
  required_version = ">= 0.13"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}