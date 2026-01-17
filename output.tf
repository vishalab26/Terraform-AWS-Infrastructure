output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

