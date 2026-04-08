#Resource block: Random String
resource "random_string" "suffix" {
    length  = 6
    upper   = false
    special = false
}

#Resouce block: AWS s3 bucket
resource "aws_s3_bucket" "demo_bucket" {
    bucket = "saas-log-bucket-${random_string.suffix.result}"

    tags = {
        Name        = "saas-log-bucket"
        Environment = "Development"
    }
  
}