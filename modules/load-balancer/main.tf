## application load balancer
resource "aws_lb" "lu-alb" {
  name               = "${var.repo-name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group
  subnets            = var.subnet_id

  #enable_delete_protection = true

  tags = {
    environment = "dev"
    repo-name   = "${var.repo-name}"
    platform    = "terraform"
  }
}

## load balancer target group
resource "aws_lb_target_group" "lu-target-group" {
  name     = "${var.repo-name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc
}

/*## load balancer attachment to target group
resource "aws_lb_target_group_attachment" "lu-tg-attachment" {
  target_group_arn = aws_lb_target_group.lu-target-group.arn
  target_id = aws_lb.lu-alb.arn
  port = 80
}*/


## load balancer listener 
resource "aws_lb_listener" "lu-alb" {
  load_balancer_arn = aws_lb.lu-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lu-target-group.arn
  }

}