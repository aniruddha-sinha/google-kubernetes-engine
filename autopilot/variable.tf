variable "k8s_service_account_id" {
  type        = string
  description = "The service account id to be used with the GKE autopilot cluster"
  default     = ""
}

variable "project_id" {
  type        = string
  description = "The gcp project id where the cluster is desired to be created"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "k8s_cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "k8s_version" {
  type        = string
  description = "the master version to be used in the GKE"
}

variable "master_auth_ip_whitelisting_name" {
  type        = string
  description = "the name of the whitelisted address block"
}

variable "public_ip_address_of_the_system" {
  type        = string
  description = "the laptops public ip address which will be using the cluster"
}
