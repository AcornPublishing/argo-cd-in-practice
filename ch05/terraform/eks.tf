module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true
  cluster_endpoint_public_access = true

  tags = {
    Environment = "test"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    root_volume_type = "gp2"
  }

  eks_managed_node_groups = {
    utility = {
      name = "utility"
      instance_type        = "t3.large"
      asg_desired_capacity = 2
    },
    application = {
      name = "application"
      instance_type        = "t3.large"
      asg_desired_capacity = 2
    }
  }
}

