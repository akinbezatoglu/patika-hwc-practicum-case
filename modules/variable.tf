variable "region" {
  default = "ap-southeast-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

# External variables
variable "auth_accesskey" {
  description = "The access key id of the user's account"
  type        = string
  sensitive = true
}

variable "auth_secretkey" {
  description = "The secret key id of the user's account"
  type        = string
  sensitive = true
}

variable "publickey" {
  description = "The public key content of generated ssh key pair file"
  type        = string
  sensitive = true
}

variable "keyname" {
  description = "The name of generated ssh key pair file"
  type        = string
  sensitive = true
}
