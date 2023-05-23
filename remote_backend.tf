resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "hossam-state-bucket"
  lifecycle {
#    prevent_destroy = true
# You Can Uncomment above line to prevent delete bucket
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lockstate-dynamodb" {
  name = "terraform-lockstate-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
   backend "s3" {
     bucket  = "hossam-state-bucket"
     key     = "dev/terraform.tfstate"
     region  = "us-east-1"
     dynamodb_table = "terraform-lockstate-dynamodb"
     encrypt = "true"
   }
 }

