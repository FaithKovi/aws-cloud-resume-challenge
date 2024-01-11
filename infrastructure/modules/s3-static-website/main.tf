provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terraformstate-acrc112" # bucket name
    region         = "us-east-1"
    dynamodb_table = "terraformstate-table-acrc112"
    encrypt        = true
    key            = "s3-static-website/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "acrc-static-website" {
  bucket = "acrc-static-website112"
  tags = {
    name = "acrc-static-website112"
  }
}

resource "aws_s3_bucket_website_configuration" "acrc-static-website" {
  bucket = aws_s3_bucket.acrc-static-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_versioning" "acrc-static-website" {
  bucket = aws_s3_bucket.acrc-static-website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket ACL Access

resource "aws_s3_bucket_ownership_controls" "acrc-static-website" {
  bucket = aws_s3_bucket.acrc-static-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "acrc-static-website" {
  bucket = aws_s3_bucket.acrc-static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acrc-static-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.acrc-static-website,
    aws_s3_bucket_public_access_block.acrc-static-website,
  ]

  bucket = aws_s3_bucket.acrc-static-website.id
  acl    = "public-read"
}

# # S3 bucket policy

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.acrc-static-website.id

  policy = <<POLICY
  {
    "Id": "Policy",
    "Statement": [
      {
        "Action": [
        "s3:GetObject"
        ],
        "Effect":"Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.acrc-static-website.bucket}/*",
        "Principal": {
          "AWS": [
            "*"
          ]
        }
      }
    ]
  }
POLICY
}