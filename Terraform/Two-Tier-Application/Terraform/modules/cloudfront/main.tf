resource "aws_cloudfront_distribution" "cloudfront-distribution" {
  origin {
    domain_name = "${var.alb_dns_name}"
    origin_id   = "alb_origin"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "${var.project_tag} CloudFront for HTTP Server"
#   default_root_object = "index.html"

  aliases             = [var.route53_record_name]

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:675982193808:certificate/4ef5e3f1-8d17-4807-aebc-54d8482f3bb3"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb_origin"

    forwarded_values {
      query_string = false
      headers      = ["*"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"  # "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    # geo_restriction {
    #   restriction_type = "none"
    # }
    geo_restriction {
      restriction_type = "whitelist"
    #   locations        = ["IN"]
      locations        = ["IN", "US", "CA"]
    }
  }

  tags = {
    Project = "${var.project_tag}"
  }
}

