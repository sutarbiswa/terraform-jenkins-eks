terraform {
  backend "s3" {
    bucket = "litun01-s3-terraform-dem0-xyz"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"

  }
}