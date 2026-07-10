module "iam" {

  source = "./modules/iam"

}

module "s3" {

  source = "./modules/s3"

  bucket_name = var.bucket_name

}

module "security_group" {

  source = "./modules/security-group"

  vpc_id = data.aws_vpc.default.id

}

module "ec2" {
  source = "./modules/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
  instance_profile  = module.iam.instance_profile_name
  bucket_name       = module.s3.bucket_name

  subnet_id = data.aws_subnets.default.ids[0]
}