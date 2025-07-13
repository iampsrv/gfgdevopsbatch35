provider "aws" {
  region = "us-east-1"
}

# Replace with a globally unique bucket name
resource "aws_s3_bucket" "static_site" {
  bucket = "abcdpranjalxyz"

  tags = {
    Name = "StaticWebsiteBucket"
  }
}

# Enable website hosting configuration
resource "aws_s3_bucket_website_configuration" "static_site_website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Allow public access (this must come before the policy)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy to allow public read access
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.static_site.arn}/*"
    }]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

# Output website URL
output "website_url" {
  value = aws_s3_bucket_website_configuration.static_site_website.website_endpoint
}
