variable "environment_name" {
    description = "Environment name {dev, staging, prod}"
    type = string
    validation {
      condition = contains(["dev", "staging", "prod"], var.environment_name)
      error_message = "environment_name must be one of dev, staging, prod"
    }
}

variable "region" {
    description = "Region name to deploy the VPC"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "CIDR range of the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_newbits" {
    description = "Subnet bites"
    type = number
    default = 8
}

variable "num_azs" {
    description = "How many AZs to spread accross"
    type = number
}

variable "single_nat_gateway" {
    description = "Whether to use a single NAT gateway for all private subnets or one per AZ"
    type = bool
    default = true
}

variable "enable_flow_logs" {
    description = "Whether to enable VPC flow logs"
    type = bool
    default = false
}

variable "flow_logs_retention_in_days" {
    description = "Number of days to retain VPC flow logs (if enabled)"
    type = number
    default = 7
}

variable "tags" {
    description = "A map of tags to assign to all resources"
    type = map(string)
    default = {}
  
}