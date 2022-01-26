data google_project "current" {
}

resource google_storage_bucket "bucket-ya" {
  project       = data.google_project.current.project_id
  name          = "${var.bucket_name}-${data.google_project.current.project_id}"
  location      = var.bucket_region
  force_destroy = true
}