resource "aws_codestarconnections_connection" "example" {
  name          = "simple-api-connection"
  provider_type = "GitHub"
}
