resource "aws_s3_bucket" "terraform-backend" {
	bucket = "naz-fakh-terraform-state-backend"
	force_destroy = true # in production, take this out to prevent accidental data loss.
}

resource "aws_s3_bucket_versioning" "terraform-backend" {
	bucket = aws_s3_bucket.terraform-backend.id
	versioning_configuration {
		status = "Enabled"
	}
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

resource "aws_s3_bucket_public_access_block" "terraform-backend" {
	bucket = aws_s3_bucket.terraform-backend.id
	block_public_acls = true
	block_public_policy = true
	ignore_public_acls = true
	restrict_public_buckets = true
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

resource "local_file" "tf_backend_config" {
	content = <<EOF
		terraform {
			backend "s3" {
				bucket = "${aws_s3_bucket.terraform-backend.bucket}"
				key = "terraform.tfstate"
				region = "us-west-2"
				dynamodb_table = "${aws_dynamodb_table.terraform-backend.name}"
				encrypt = true
			}
		}
	EOF
	filename = "${path.module}/../backend_config.tf"
}