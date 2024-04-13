/* 
	Backend configuration for storing terraform state file in S3 bucket.
	- S3 bucket
	- S3 bucket versioning
	- S3 bucket ownership controls
	- S3 bucket ACL
	- S3 bucket server side encryption
	- S3 bucket public access block
	- DynamoDB table for state locking
	- Local file for storing backend configuration
*/

resource "aws_s3_bucket" "terraform-backend" {
	/* 
		This is the S3 bucket that will be created.
	*/

	bucket = "naz-fakh-terraform-state-backend"
	force_destroy = true # in production, take this out to prevent accidental data loss.
}

resource "aws_s3_bucket_versioning" "terraform-backend" {
	/* 
		This is the versioning configuration for the S3 bucket.
	*/

	bucket = aws_s3_bucket.terraform-backend.id
	versioning_configuration {
		status = "Enabled"
	}
}

resource "aws_s3_bucket_ownership_controls" "terraform-backend" {
	/* 
		This is the ownership controls configuration for the S3 bucket.
	*/

	bucket = aws_s3_bucket.terraform-backend.id
	rule {
		object_ownership = "BucketOwnerPreferred"
	}
}

resource "aws_s3_bucket_acl" "terraform-backend" {
	/* 
		This is the ACL configuration for the S3 bucket.
	*/

	bucket = aws_s3_bucket.terraform-backend.id
	depends_on = [aws_s3_bucket_ownership_controls.terraform-backend]
	acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-backend" {
	/* 
		This is the server side encryption configuration for the S3 bucket.
	*/

	bucket = aws_s3_bucket.terraform-backend.id
	rule {
		apply_server_side_encryption_by_default {
			sse_algorithm = "AES256"
		}
	}
}

resource "aws_s3_bucket_public_access_block" "terraform-backend" {
	/* 
		This is the public access block configuration for the S3 bucket.
	*/

	bucket = aws_s3_bucket.terraform-backend.id
	block_public_acls = true
	block_public_policy = true
	ignore_public_acls = true
	restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-backend" {
	/* 
		This is the DynamoDB table that will be created.
	*/

	name = "naz-fakh-terraform-state-lock"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"
	attribute {
		name = "LockID"
		type = "S"
	}
}

resource "local_file" "tf_backend_config" {
	/* 
		This is the local file that will be created to store the backend configuration.
	*/
	
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