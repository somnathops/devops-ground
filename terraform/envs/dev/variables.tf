variable "region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
}

variable "environment_name" {
    description = "Environment name"
    type        = string
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type        = string
}

variable "num_azs" {
    description = "Number of AZs"
    type        = number
}

variable "single_nat_gateway" {
    description = "Use single NAT gateway"
    type        = bool
}

variable "enable_flow_logs" {
    description = "Enable VPC flow logs"
    type        = bool
}

variable "tags" {
    description = "Tags to apply to all resources"
    type        = map(string)
    default     = {}
}