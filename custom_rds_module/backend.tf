terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "xxxx"
    key            = "dev/rds/terraform.tfstate"
    encrypt        = true
    #dynamodb_table = "terraform-dev-lock"
  }
}