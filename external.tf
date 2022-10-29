data "external" "auth" {
  program = ["bash", "${path.module}/external/key.sh"]
}

data "external" "ssh" {
  program = ["bash", "${path.module}/external/ssh-key-generator.sh"]
}
