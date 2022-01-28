terraform {
  backend "gcs" {
    bucket  = "mw-argo-workflows-artifacts"
    prefix  = "terraform/state"
  }
}