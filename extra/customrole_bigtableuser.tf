# we added permissions for table creation aiming to give more flexibility to the devs. 
# But they won't have permissions to change instance configurations.
resource "google_organization_iam_custom_role" "CustomBigtableUser" {
  role_id = "CustomBigtableUser"
  title   = "Custom Bigtable User"
  # ORG LEVEL
  org_id      = "<your organization id>"
  description = "Custom role created by terraform. It lets the users create/update/delete/undelete tables"
  permissions = ["bigtable.appProfiles.get", "bigtable.appProfiles.list", "bigtable.authorizedViews.get", "bigtable.authorizedViews.list", "bigtable.authorizedViews.mutateRows", "bigtable.authorizedViews.readRows",
    "bigtable.authorizedViews.sampleRowKeys", "bigtable.backups.get", "bigtable.backups.list", "bigtable.clusters.get", "bigtable.clusters.list", "bigtable.hotTablets.list", "bigtable.instances.executeQuery", "bigtable.instances.get",
    "bigtable.instances.list", "bigtable.instances.ping", "bigtable.keyvisualizer.get", "bigtable.keyvisualizer.list", "bigtable.locations.list", "bigtable.tables.checkConsistency", "bigtable.tables.generateConsistencyToken",
    "bigtable.tables.get", "bigtable.tables.list", "bigtable.tables.create", "bigtable.tables.update", "bigtable.tables.delete", "bigtable.tables.undelete", "bigtable.tables.mutateRows", "bigtable.tables.readRows",
  "bigtable.tables.sampleRowKeys", "monitoring.metricDescriptors.get", "monitoring.metricDescriptors.list", "monitoring.timeSeries.create", "monitoring.timeSeries.list", "resourcemanager.projects.get"]
}