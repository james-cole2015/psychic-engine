data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
## Jenkins Launch Template
resource "aws_launch_template" "jenkins_main-launch-template" {
  name = "${var.repo-name}-jenkins_main-LT"

  credit_specification {
    cpu_credits = "standard"
  }

  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name      = var.key_name
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = var.security_group

  user_data = filebase64("jenkins-boot.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "Jenkins Main Controller"
      environment = "production"
      platform    = "terraform"
      user        = "AveryClark"
      repo-name = "${var.repo-name}"
    }
  }
}


## Auto Scaling Groups
resource "aws_autoscaling_group" "asg" {
  name = "${var.repo-name}-jenkins_main-asg"
  min_size            = 1
  max_size            = 2
  vpc_zone_identifier = [var.subnet_id]
  target_group_arns   = [var.target_group_arns]

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.jenkins_main-launch-template.id
    version = "$Latest"
  }
}