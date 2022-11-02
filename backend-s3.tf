# Resources or Main configs of the ROOT module 
# This is the main configuration takes place
# See Resources and Modules documentation on Terraform

# AWS Bucket - a cloud storage
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "agag_tf_state" {
  bucket        = "agag-tf-state-v1"
  force_destroy = true
  lifecycle {
    prevent_destroy = false # bolean
  }
  tags = {
    Name        = "agag-TF-State"
    Environment = var.tf_environment
  }
}
# Access control list (ACL)
resource "aws_s3_bucket_acl" "agag_acl" {
  bucket = aws_s3_bucket.agag_tf_state.id
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "agag_bucket_versioning" {
  bucket = aws_s3_bucket.agag_tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
#see @https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
# To avoid unnecessary billing for usage encryption resources
/*
resource "aws_kms_key" "agag_tf_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "agag_s3_bucket_encrypt" {
  bucket = aws_s3_bucket.agag_tf_state.bucket

  rule {
    agagly_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.agag_tf_key.arn
      sse_algorithm     = "aws:kms" #option: AES256
    }
  }
}
*/
resource "aws_dynamodb_table" "agag_tf_locking" {
  name           = "agag-tf-state-locking"
  read_capacity  = 20
  write_capacity = 20
  billing_mode   = "PROVISIONED" # option: PAY_PER_REQUEST
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = "agag-TF-State"
    Environment = var.tf_environment
  }
}