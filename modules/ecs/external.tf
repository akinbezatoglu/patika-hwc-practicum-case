data "external" "ssh" {
  program = ["bash", "${path.root}/external/ssh-key-generator.sh"]
}