resource "google_bigtable_instance" "instance" {
  name = var.name
  dynamic "cluster" {
    for_each = var.cluster != null ? var.cluster : []
    content {
      cluster_id = cluster.value.cluster_id
      zone       = lookup(cluster.value, "zone", null)
      num_nodes  = lookup(cluster.value, "num_nodes", null)
      dynamic "autoscaling_config" {
        for_each = cluster.value.autoscaling_config != null ? [cluster.value.autoscaling_config] : []
        content {
          min_nodes      = autoscaling_config.value.min_nodes
          max_nodes      = autoscaling_config.value.max_nodes
          cpu_target     = autoscaling_config.value.cpu_target
          storage_target = autoscaling_config.value.storage_target
        }
      }
      storage_type = lookup(cluster.value, "storage_type", null)
      kms_key_name = lookup(cluster.value, "kms_key_name", null)
    }
  }
  project             = var.project
  display_name        = var.display_name
  force_destroy       = var.force_destroy
  deletion_protection = var.deletion_protection
  labels              = var.labels
  #terraform_labels    = var.terraform_labels
  #effective_labels    = var.effective_labels
  lifecycle {
    ignore_changes = []
  }
}

resource "google_project_iam_binding" "bigtable" {
  count = length(var.members) == 0 ? 0 : 1
  project = var.project
  role    = "organizations/225850268505/roles/CustomBigtableUser"
  members = var.members
}