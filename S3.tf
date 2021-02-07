resource "aws_s3_bucket" "bucket" {
  bucket = "s3-terraform-bucket-global"
  acl    = "private"  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
lifecycle {
    create_before_destroy = true
  }
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "profile"
  acl    = "private"  # or can be "public-read"
  source = "/root/production/table.sql"
  etag = filemd5("/root/production/table.sql")
lifecycle {
    create_before_destroy = true
  }

}
