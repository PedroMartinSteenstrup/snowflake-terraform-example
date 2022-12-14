# Configure the AWS Provider, credentials are source from $HOME/.aws/credentials
variable "aws_profile" {
  default = ""
}
provider "aws" {
  region = "eu-west-2"
  profile = var.aws_profile
}