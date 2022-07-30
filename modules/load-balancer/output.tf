output "elb_id" {
  value = aws_lb_target_group.lu-target-group.arn
}

output "elb_dns" {
  value = aws_lb.lu-alb.dns_name
}

output "tg_arn" {
  value = aws_lb_target_group.lu-target-group.arn
}