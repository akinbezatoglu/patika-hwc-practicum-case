variable "region" {
  default = "ap-southeast-1"
}

# External variables
variable "auth_accesskey" {
  description = "The access key id of the user's account"
  type        = string
}

variable "auth_secretkey" {
  description = "The secret key id of the user's account"
  type        = string
}

variable "publickey" {
  description = "The public key content of generated ssh key pair file"
  type        = string
}

variable "keyname" {
  description = "The name of generated ssh key pair file"
  type        = string
}
