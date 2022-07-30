data "aws_availability_zones" "available" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  name                         = var.vpc_name
  cidr                         = var.cidr_block
  azs                          = data.aws_availability_zones.available.names
  private_subnets              = var.private_sn
  public_subnets               = var.public_sn
  create_igw                   = true
  create_database_subnet_group = true
  #enable_nat_gateway           = true
  single_nat_gateway = true
}


### CHANGE SSH BACK WHEN YOU CREATE THE BASTION HOST!! 
resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg-${var.repo-name}"
  description = "Allow webserver traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from the bastion host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.terraform_ip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.repo-name}-SG"
  }
  ingress {
    description = "https from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "terraform_ip" {
  url = "http://ipv4.icanhazip.com"
}


resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg-${var.repo-name}"
  description = "Allow bastion host traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from the hosting server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.terraform_ip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /*
  ingress {
    description = "http from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  */
  tags = {
    Name = "${var.repo-name}-SG"
  }
  ingress {
    description = "https from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}