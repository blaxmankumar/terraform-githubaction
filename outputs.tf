output "public_ip" {

  value = aws_instance.server.public_ip
}

output "bucket_name" {

  value = aws_s3_bucket.bucket.bucket
}