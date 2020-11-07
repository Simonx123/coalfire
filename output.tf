output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = module.ec2_cluster.public_ip[0]
}


output "alb_dns_name" {
  description = "ALB DNS NAME"
  value       = module.alb.this_lb_dns_name
}