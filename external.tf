data "external" "ssh" {
  program = ["bash", "${path.module}/external/ssh-key-generator.sh"]
}