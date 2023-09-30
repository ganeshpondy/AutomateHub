output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cloudfront-distribution.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.cloudfront-distribution.hosted_zone_id
}
