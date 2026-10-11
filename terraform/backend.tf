terraform {
  backend "s3" {
    bucket       = "todo-tfstate-ny1849288-2026"
    key          = "todo-app/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
    encrypt      = true
  }
}