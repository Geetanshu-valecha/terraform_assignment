module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "iam_roles" {
  source       = "./modules/iam_roles"
  project_name = var.project_name
}

module "s3_cloudfront" {
  source       = "./modules/s3_cloudfront"
  project_name = var.project_name
}

module "rds" {
  source       = "./modules/rds_postgres"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  sg_id        = module.security_groups.rds_sg_id
}

module "ecs_fargate" {
  source         = "./modules/ecs_fargate"
  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  public_subnets = module.vpc.public_subnet_ids
  sg_id          = module.security_groups.ecs_sg_id
  execution_role = module.iam_roles.ecs_execution_role_arn
  task_role      = module.iam_roles.ecs_task_role_arn
  rds_endpoint   = module.rds.endpoint
  cloudfront_url = module.s3_cloudfront.cloudfront_domain
}