environment_name   = "dev"
region             = "us-west-2"
vpc_cidr           = "10.0.0.0/16"
num_azs            = 2
single_nat_gateway = true
enable_flow_logs   = false

tags = {
    Environment = "dev"
    Owner       = "somnathmanna096@gmail.com"
    ManagedBy   = "terraform"
}