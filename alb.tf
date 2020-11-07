module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             =  module.vpc.vpc_id
  subnets            =  module.vpc.public_subnets
  security_groups    = [aws_security_group.lb-sg.id]


  target_groups = [
    {
      name_prefix      = "pref-0"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = 80
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
    }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "forward"
    }
  ]

  tags = {
    Environment = "Test"
  }
}


resource "aws_lb_target_group_attachment" "jenkins-master-attach" {
  target_group_arn = module.alb.target_group_arns[0]
  target_id        = module.ec2_cluster_private.id[0]
  port             = var.webserver-port
}