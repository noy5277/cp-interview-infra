terraform {
  backend "s3" {
    bucket       = "hello-world-crossplane-demo"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}
