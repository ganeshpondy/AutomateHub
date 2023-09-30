# output "vpc_resource_level_tags" {
#   value = aws_vpc.vpc.tags
# }

# output "aws_availability_zones" {
#   value = data.aws_availability_zones.available_zones.names
# }

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}

output "route53_Name" {
  value = var.route53_record_name
}