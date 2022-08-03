module "jenkins_main-asg" {
  source    = "./modules/jenkins_main-asg"
  repo-name = var.repo-name
  #vpc_zone_identifier = module.networking.vpc.vpc_id
  subnet_id      = module.networking.vpc.public_subnets[0]
  security_group = [module.networking.jenkins-sg.id, module.networking.jenkins-ssh-sg.id]
  key_name       = module.key_gen.key_name
  #target_group_arns = module.elastic-load-balancer.elb_id
}

module "networking" {
  source    = "./modules/vpc"
  repo-name = var.repo-name
}


module "key_gen" {
  source    = "./modules/aws_keys"
  repo-name = var.repo-name
}

/*module "elastic-load-balancer" {
  source         = "./modules/load-balancer"
  repo-name      = var.repo-name
  security_group = [module.networking.jenkins-sg.id]
  subnet_id      = [module.networking.vpc.public_subnets[0], module.networking.vpc.public_subnets[1]]
  vpc            = module.networking.vpc.vpc_id
}*/

module "jenkins_node-asg" {
  source    = "./modules/jenkins_nodes-asg"
  repo-name = var.repo-name
  #vpc_zone_identifier = module.networking.vpc.vpc_id
  subnet_id      = module.networking.vpc.public_subnets[0]
  security_group = [module.networking.jenkins-sg.id]
  key_name       = module.key_gen.key_name
  image_id       = module.aws_data.ami.id
}

module "aws_data" {
  source    = "./modules/aws_data"
  user-name = var.user-name
}