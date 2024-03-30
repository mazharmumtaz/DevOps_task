provider "aws" {
  region = "us-west-2" // Specify your desired AWS region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.5.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.21"
  subnets         = ["subnet-abc12345", "subnet-def67890"] // Specify your subnet IDs
  vpc_id          = "vpc-12345678" // Specify your VPC ID
  node_group_name = "my-node-group"
  node_group_instance_type = "t3.medium"
  node_group_desired_capacity = 2
  node_group_min_size = 1
  node_group_max_size = 3
}
// commands to initialize terraaform configuration "terraform init"
// terraaform plane 
// terraforn apply