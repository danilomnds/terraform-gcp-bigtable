# Module - BigTable
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of BigTable.

## Compatibility Matrix

| Module Version | Terraform Version | Google Version     |
|----------------|-------------------| ------------------ |
| v1.0.0         | v1.9.5            | 6.4.0              |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case
```hcl
module "<bigtablename>-<env>" {    
  source = "git::https://https://github.com/danilomnds/terraform-gcp-module-bigtable?ref=v0.1.0"
  project      = "project_id"
  name         = "bigtablename-fqa1"
  display_name = "bigtablename-fqa1"
  cluster = [{
    cluster_id   = "bigtablename-fqa1-c1"
    zone         = "southamerica-east1-a"
    num_nodes    = 1
    storage_type = "SSD"
  }]  
  labels = {
    diretoria   = "ctio"
    area        = "area"
    system      = "system"    
    environment = "fqa"
    projinfra   = "0001"
    dm          = "00000000"
    provider    = "gcp"
    region      = "southamerica-east1"
  }
}
output "instance_id" {
  value = module.<bigtablename>-<env>.instance_id
}
```

## Default use case plus RBAC
```hcl
module "<bigtablename>-<env>" {    
  source = "git::https://github.com/danilomnds/terraform-gcp-module-bigtable?ref=v0.1.0"  
  project      = "project_id"
  name         = "bigtablename-fqa1"
  display_name = "bigtablename-fqa1"
  cluster = [{
    cluster_id   = "bigtablename-fqa1-c1"
    zone         = "southamerica-east1-a"
    num_nodes    = 1
    storage_type = "SSD"
  }]  
  members = ["group:GRP_GCP-SYSTEM-PRD@timbrasil.com.br"]
  labels = {
    diretoria   = "ctio"
    area        = "area"
    system      = "system"    
    environment = "fqa"
    projinfra   = "0001"
    dm          = "00000000"
    provider    = "gcp"
    region      = "southamerica-east1"
  }
}
output "instance_id" {
  value = module.<bigtablename>-<env>.instance_id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name (also called Instance Id in the Cloud Console) of the Cloud Bigtable instance | `string` | n/a | `Yes` |
| cluster | A block of cluster configuration options. This can be specified at least once, and up to as many as possible within 8 cloud regions | `list(object({}))` | n/a | `Yes` |
| project | The ID of the project in which the resource belongs. If it is not provided, the provider project is used | `string` | n/a | No |
| display_name | The human-readable display name of the Bigtable instance | `string` | n/a | No |
| force_destroy | Deleting a BigTable instance can be blocked if any backups are present in the instance | `bool` | n/a | No |
| deletion_protection | Whether Terraform will be prevented from destroying the instance | `bool` | n/a | No |
| labels | A set of key/value label pairs to assign to the resource | `map(string)` | n/a | No |
| terraform_labels | The combination of labels configured directly on the resource and default labels configured on the provider | `map(string)` | n/a | No |
| effective_labels | All of labels (key/value pairs) present on the resource in GCP, including the labels configured through Terraform, other clients and services | `map(string)` | n/a | No |
| members | list of azure AD groups that will use the resource | `list(string)` | n/a | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| cluster | cluster_id | The ID of the Cloud Bigtable cluster | `string` | n/a | `Yes` |
| cluster | zone | The zone to create the Cloud Bigtable cluster in. If it not specified, the provider zone is used | `string` | n/a | No |
| cluster | num_nodes | The number of nodes in the cluster | `number` | n/a | No |
| cluster | autoscaling_config (min_nodes) | The minimum number of nodes for autoscaling | `number` | n/a | No |
| cluster | autoscaling_config (max_nodes) | The maximum number of nodes for autoscaling | `number` | n/a | No |
| cluster | autoscaling_config (cpu_target) | The target CPU utilization for autoscaling, in percentage. Must be between 10 and 80 | `number` | n/a | No |
| cluster | autoscaling_config (storage_target) | The target storage utilization for autoscaling, in GB, for each node in a cluster | `number` | n/a | No |
| cluster | storage_type | The storage type to use. One of "SSD" or "HDD". Defaults to "SSD" | `string` | n/a | No |
| cluster | kms_key_name | Describes the Cloud KMS encryption key that will be used to protect the destination Bigtable cluster | `string` | n/a | No |

## Output variables

| Name | Description |
|------|-------------|
| instance_id | bigtable instance id|

## Documentation
BigTable: <br>
[https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance)