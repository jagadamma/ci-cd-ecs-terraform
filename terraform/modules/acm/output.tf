output "multi_certificate_arn" {
  description = "ARN of SAN certificate"
  value       = aws_acm_certificate.multi.arn
}
