variable "remote_state_bucket_name" {
  description = "value of bucket name"
  type = string
}

variable "aws_dynamodb_table_name" {
  description = "value of dynamodb table name"
  type = string
}

variable "region" {
  description = "value of preferred region"
  type = string
}