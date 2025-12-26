resource "aws_acm_certificate" "multi" {
  domain_name               = var.multi_domain_cert.domain_name
  subject_alternative_names = var.multi_domain_cert.subject_alternative_names
  validation_method         = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.common_tags,
    { Name = var.multi_domain_cert.domain_name }
  )
}

resource "aws_route53_record" "multi_validation" {
  for_each = {
    for dvo in aws_acm_certificate.multi.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = var.hosted_zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 300
  records = [each.value.resource_record_value]
}

resource "aws_acm_certificate_validation" "multi_validation_complete" {
  certificate_arn = aws_acm_certificate.multi.arn
  validation_record_fqdns = [
    for record in aws_route53_record.multi_validation :
    record.fqdn
  ]
}
