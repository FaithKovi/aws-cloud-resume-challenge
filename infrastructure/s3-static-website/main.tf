provider "aws" {
    region = "us-east-1"

    # Skip these to make it faster
    skip_metadata_api_check = true
    skip_region_validation = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    }


resource "aws_kms_key" "objects" {
    description = "KMS key used to encrypt bucket objects"
    deletion_window_in_days = 7
}

module "s3_bucket" {
    source = ""
    bucket = acrc-bucket112
    
    website = {
        index_document = "index.html"
        error_document = "error.html"
    }  
}
