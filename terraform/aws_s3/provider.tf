# Configure the AWS Provider, credentials are source from $HOME/.aws/credentials
provider "aws" {
  region = "eu-west-2"
  profile = var.shared.aws_profile
}