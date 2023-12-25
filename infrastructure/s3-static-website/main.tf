






terraform {
    backend "local" {
        path = "terraform.tfstate"
    }
}

data "terraform_remote_state" "admin" {
    backend = "local"

    config = {
        path = var.path
    }
}