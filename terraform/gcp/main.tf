provider "google" {
  credentials         = file("my_credentials.json")
  project             = "hybrid-lore-308816"
  region              = "us-central1"
  zone                = "us-central1-c"
}

resource "google_container_cluster" "primary" {
  name                = "cluster-1"
  location            = "us-central1-c"
  initial_node_count  = 2
  
  node_config {
    machine_type      = "e2-micro"
    disk_size_gb      = "10"
  }
}

resource "google_cloudbuild_trigger" "Chess-cloudbuild-trigger" {
  name                = "Chess-cloudbuild-trigger"  
  description         = "Nodejs Chess Builder by Terraform"
  
  tags                = [ "SoftServe" ]

  trigger_template {
    branch_name       = ".*"
    repo_name         = "github_mykolabakun_my-nodejs-chess"
  }

  substitutions = {
    _TEST             = "test"
  }

  filename            = "cloudbuild.yaml"
}
