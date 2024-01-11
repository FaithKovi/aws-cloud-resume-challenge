module "remote_backend" {
    source = "./infrastructure/modules/remote-backend-infra"
    bucket = var.remote_state_bucket_name
    aws_dynamodb_table = var.aws_dynamodb_table_name
}

# data "terraform_remote_state" "db" {
#     backend = "s3"

#     config = {
#         bucket = var.remote_state_bucket_name
#         key = var.remote_state_bucket_name
#         region = var.region

#     }
# }

module "s3_static_website" {
    source = "./infrastructure/modules/s3-static-website"
    

    # depends_on = [ data.terraform_remote_state.remote_state ]
}