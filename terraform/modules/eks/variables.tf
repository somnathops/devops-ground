variable "environment_name" {
    description = "The name of the environment (e.g., dev, staging, prod)"
    type        = string
    default     = "dev" 
    validation {
      condition = contains(["dev", "staging", "prod"], var.environment_name)
      error_message = "environment_name must be one of dev, staging, prod"
    } 
}

variable "region" {
    description = "The AWS region to deploy the EKS cluster"
    type        = string
    default     = "us-west-2"
  
}

variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
  
}

variable "instance_type" {
    description = "The EC2 instance type for the worker nodes"
    type        = string
    default     = "t3.medium"
  
}

variable "min_nodes" {
    description = "The minimum number of worker nodes in the EKS cluster"
    type        = number 
}

variable "max_nodes" {
    description = "The maximum number of worker nodes in the EKS cluster"
    type        = number
}

variable "desired_nodes" {
    description = "The desired number of worker nodes in the EKS cluster"
    type        = number
}

variable "vpc_state_bucket" {
    description = "The S3 bucket name for storing VPC state"
    type        = string
}

variable "vpc_state_key" {
    description = "The S3 key for storing VPC state"
    type        = string
}

variable "tags" {
    description = "A map of tags to assign to all resources"
    type        = map(string)
    default     = {}
  
}

variable "kubernetes_version" {
    description = "Kubernetes version for EKS cluster"
    type = string
    default = "1.30"
}