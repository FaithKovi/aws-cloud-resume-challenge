variable "name" {
    description = "name of the s3 bucket for storing terraform state"
    type = string
}

variable "region" {
    description = "region the infrastructure is deployed to"
    type = string
}
