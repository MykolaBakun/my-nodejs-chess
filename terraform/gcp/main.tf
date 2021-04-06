provider "google" {
  credentials = file("my_credentials.json")
  project = "hybrid-lore-308816"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_container_cluster" "primary" {
  name     = "cluster-1"
  location = "us-central1-c"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 2
  
  node_config {
    machine_type = "e2-micro"
    disk_size_gb = "10"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  location   = "us-central1-c"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = "10"
  }
}


resource "google_cloudbuild_trigger" "Chess-cloudbuild-trigger" {
  name = "Chess-cloudbuild-trigger"  
  description = "Nodejs Chess Builder by Terraform"
  
  tags = [ "SoftServe" ]

  trigger_template {
    branch_name = ".*"
    repo_name   = "github_mykolabakun_my-nodejs-chess"
  }

  substitutions = {
    _TEST = "test"
    _MYKOLA = "mykola"
  }

  filename = "cloudbuild.yaml"
}