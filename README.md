# Kubernetes Engine Module
`module "MODULE_NAME" { 
  depends_on = [
    SOMETHING...
  ]

  source = "SOURCE/REPO/PATH"

  k8s_cluster_name                 = "CLUSTER_NAME"
  project_id                       = "PROJECT_ID"
  region                           = "us-central1"
  k8s_version                      = data.google_container_engine_versions.k8s_versions.release_channel_default_version["STABLE"]
  master_auth_ip_whitelisting_name = "my-mac-public-ip"
  public_ip_address_of_the_system  = "PUBLIC-IP-OF-YOUR-SYSTEM"
}`