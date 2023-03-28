provider "google" {
  project = "i4t-project"
  region  = "us-central1"
}

resource "google_project" "i4t_project" {
  name            = "i4t Project"
  project_id      = "i4t-project-id"
  billing_account = "014109-523BEF-04441E"
}

resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = true
}

resource "google_kubernetes_cluster" "kubernetes" {
  name               = var.cluster_name
  location           = "us-central1"
  initial_node_count = 1
  node_config {
    machine_type = "n1-standard-1"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}

resource "google_container_node_pool" "pool" {
  name       = "default-pool"
  location   = google_container_cluster.cluster.location
  cluster    = google_container_cluster.cluster.name
  node_count = 1
  node_config {
    machine_type = "n1-standard-1"
  }
}
