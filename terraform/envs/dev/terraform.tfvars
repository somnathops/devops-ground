#vpc values
environment_name   = "dev"
region             = "us-west-2"
vpc_cidr           = "10.0.0.0/16"
num_azs            = 2
single_nat_gateway = true
enable_flow_logs   = false

#eks values
cluster_name = "control-plane-dev"
kubernetes_version = "1.30"
instance_type = "t3.medium"
min_nodes = 1
max_nodes = 3
desired_nodes = 2
vpc_state_bucket = "terraform-state-bucket-157788111769"
vpc_state_key = "dev/terraform.tfstate"

tags = {
    Environment = "dev"
    Owner       = "somnathmanna096@gmail.com"
    ManagedBy   = "terraform"
}