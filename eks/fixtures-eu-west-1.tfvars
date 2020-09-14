region = "eu-west-1"

availability_zones = ["eu-west-1a", "eu-west-1b"]

namespace = "jm"

stage = "dev"

name = "pachd"

kubernetes_version = "1.17"

oidc_provider_enabled = true

enabled_cluster_log_types = ["audit"]

cluster_log_retention_period = 7

instance_types = ["t2.large"]

desired_size = 2

max_size = 4

min_size = 1

disk_size = 40

kubernetes_labels = {}
