module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs                  = data.aws_availability_zones.az.names
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernets.io/cluster/eks" = "shared"
  }
  public_subnet_tags = {
    "kubernets.io/cluster/eks" = "shared"
    "kubernets.io/role/elb"    = "1"
  }
  private_subnet_tags = {
    "kubernets.io/cluster/eks"       = "shared"
    "kubernets.io/role/internal-elb" = "1"
  }

}

# EKS Cluster creation:

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"
  cluster_endpoint_public_access = true
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      max_size      = 3
      min_size      = 1
      desired_size  = 2
      instance_type = ["t2.small"]

    }

  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}