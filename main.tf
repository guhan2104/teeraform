provider "aws" {
  region  = var.region_name
  profile = "default1"
}
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}