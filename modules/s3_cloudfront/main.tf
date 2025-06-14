resource "aws_s3_bucket" "frontend" {
  bucket = "${var.project_name}-frontend-bucket"
 
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
 
  tags = {
    Name = "${var.project_name}-frontend"
  }
}
 
resource "aws_cloudfront_distribution" "frontend" {
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "s3-frontend"
  }
 
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
 
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-frontend"
 
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
 
  viewer_certificate {
    cloudfront_default_certificate = true
  }
 
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
 
  tags = {
    Name = "${var.project_name}-cloudfront"
  }
}