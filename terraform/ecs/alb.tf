resource "aws_alb" "alb" {
  name               = "brawlcode-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids
}

resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301" # permanent
    }
  }
}

resource "aws_alb_listener" "alb_https_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<html><body><h1>404: Not Found</h1></body></html>"
      status_code  = "404"
    }
  }
}

# Target Groups
resource "aws_lb_target_group" "api_gateway" {

  name        = "api-gateway-tg"
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    interval            = 30
    protocol            = "HTTP"
    matcher             = "200" # Added matcher for success codes
  }
}

resource "aws_lb_listener_rule" "api_gateway" {
  # Creates a rule and attach it to the https alb
  # By default will hit gateway first
  listener_arn = aws_alb_listener.alb_https_listener.arn
  priority     = 1

  # Forwards requests to the target group for this service
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_gateway.arn
  }

  # Matches requests based on the URL path pattern defined for the service
  condition {
    path_pattern {
      values = ["/*"] # This will match all paths
    }
  }
}

data "aws_acm_certificate" "cert" {
  domain   = "*.brawlcode.com"
  statuses = ["ISSUED"]
}
