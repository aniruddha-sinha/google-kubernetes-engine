# data "google_service_account" "custom_service_account" {
#   account_id = var.k8s_service_account_id
#   project    = var.project_id
# }

data "google_compute_network" "gke_network" {
  name    = "vpc-${var.project_id}"
  project = var.project_id
}

data "google_compute_subnetwork" "gke_subnetwork" {
  name    = "subnet-us-0"
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_container_cluster" "gke_autopilot_private" {
  provider           = google-beta
  name               = var.k8s_cluster_name
  project            = var.project_id
  location           = var.region
  network            = data.google_compute_network.gke_network.name
  subnetwork         = data.google_compute_subnetwork.gke_subnetwork.name
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  min_master_version = var.k8s_version
  enable_autopilot   = true
  //service_account    = google_service_account.custom_service_account.email

  ip_allocation_policy {}

  private_cluster_config {
    enable_private_endpoint = "false"
    enable_private_nodes    = "true"
    master_ipv4_cidr_block  = "172.16.0.16/28"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  addons_config {
    cloudrun_config { disabled = true }
    http_load_balancing { disabled = false }
    horizontal_pod_autoscaling { disabled = false }
  }

  enable_tpu              = false
  enable_legacy_abac      = false
  enable_kubernetes_alpha = false

  vertical_pod_autoscaling { enabled = true }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = var.master_auth_ip_whitelisting_name
      cidr_block   = var.public_ip_address_of_the_system
    }
  }
}