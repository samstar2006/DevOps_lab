terraform {
  cloud {
    organization = "ktc-terransible"

    workspaces {
      name = "terransible"
    }
  }
}

# # Adding Backend as S3 for Remote State Storage
# terraform {
#   backend "s3" {
#     bucket = "terramaven-remote-state-storage"
#     key    = "workspaces/terraform.tfstate"
#     region = "us-east-1"
#     encrypt = true
#     shared_credentials_file = "~/.aws/credentials"

#     # For State Locking
#     dynamodb_table = "terraform-dev-state-table"
#   }
# }

# # Create S3 bucket for remote state storage
# resource "aws_s3_bucket" "terraform_state_bucket" {
#   bucket = "terramaven-remote-state-storage"
# }


