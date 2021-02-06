data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")
}