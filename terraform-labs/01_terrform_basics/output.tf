#Output block
output "s3_bucket_name" {
    value = aws_s3_bucket.demo_bucket.bucket
    description = "The name of the S3 bucket created"
}

output "s3_bucket_id" {
    value = aws_s3_bucket.demo_bucket.id
    description = "The ID of the S3 bucket created"
}