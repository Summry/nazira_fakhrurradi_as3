terraform {
  backend "s3" {
    bucket = "naz-fakh-terraform-state-backend"
    key    = "terraform.tfstate"
    region = var.region
    encrypt = true
    dynamodb_table = "naz-fakh-terraform-state-lock"
  }
}

resource "aws_s3_bucket" "terraform-backend" {
	bucket = "naz-fakh-terraform-state-backend"
	force_destroy = true # in production, take this out
}

resource "aws_s3_bucket_ownership_controls" "terraform-backend" {
	bucket = aws_s3_bucket.terraform-backend.id
	rule {
		object_ownership = "BucketOwnerPreferred"
	}
}

resource "aws_s3_bucket_acl" "terraform-backend" {
	bucket = aws_s3_bucket.terraform-backend.id
	depends_on = [aws_s3_bucket_ownership_controls.terraform-backend]
	acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-backend" {
	bucket = aws_s3_bucket.terraform-backend.id
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_dynamodb_table" "terraform-backend" {
	name = "naz-fakh-terraform-state-lock"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"
	attribute {
		name = "LockID"
		type = "S"
	}
}