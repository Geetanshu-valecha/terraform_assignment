output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "cloudfront_domain" {
  value = module.s3_cloudfront.cloudfront_domain
}