
## Jenkins Launch Template
resource "aws_launch_template" "jenkins_node-launch-template" {
  name = "${var.repo-name}-jenkins_node-LT"

  credit_specification {
    cpu_credits = "standard"
  }

  image_id               = var.image_id
  instance_type          = var.instance-type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group

  user_data = filebase64("jenkins-boot.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Jenkins Node"
    }
  }
}


## Auto Scaling Groups
resource "aws_autoscaling_group" "asg" {
  name                = "${var.repo-name}-jenkins_node-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = [var.subnet_id]

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.jenkins_node-launch-template.id
    version = "$Latest"
  }
}