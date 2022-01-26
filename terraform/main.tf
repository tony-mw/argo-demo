module "bucket" {
  source = "./modules"
  bucket_name = var.bucket_name
  bucket_region = var.bucket_region
}