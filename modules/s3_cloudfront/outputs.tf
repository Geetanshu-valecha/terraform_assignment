output "cloudfront_domain" {
  value = aws_cloudfront_distribution.frontend.domain_name
}