terraform {

  backend "s3" {
    bucket       = "mlops-project-bucket-dhiraj"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}