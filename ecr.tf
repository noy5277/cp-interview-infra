module "ecr" {
  source          = "./modules/ecr"
  region          = var.aws_region
  repository_name = var.ecr_repository_name
}