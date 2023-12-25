terraform {
    backend "s3" {
        bucket = "terraformstate-acrc112" # bucket name
        key = "Terraform-State"
        region = "us-east-1"
        encrypt = true
    }
}