terraform {
backend "s3" {
region = "us-east-1"
bucket = "jyo-demo-bucket-mono"
key = "prod/terraform.tfstate"
}
}
