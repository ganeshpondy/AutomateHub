# Import Public Zone Details
data "aws_route53_zone" "route53-main" {
#   name         = "ganeshpondy.link"
  name = var.route53_zone_name
  private_zone = false
}

# simple-routing-policy with ALB
resource "aws_route53_record" "route53-record-name" {
  zone_id = data.aws_route53_zone.route53-main.zone_id
#   name    = "terrafrom.ganeshpondy.link"
  name    = var.route53_record_name
  type    = "A"
#   ttl     = 300
  alias {
    # name                   = var.alb_dns_name   # For Application LoadBalancer
    # zone_id                = var.alb_zone_id
    name                   = var.cloudfront_domain_name   # Cloudfront Name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = true
  }
}

