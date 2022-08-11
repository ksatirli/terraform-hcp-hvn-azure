# re-use the `basic` example to make the code in this example more lightweight
# see https://registry.terraform.io/modules/ksatirli/hvn-azure/hcp/
module "basic" {
  source = "../basic"
}

# see https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/consul_cluster
resource "hcp_consul_cluster" "main" {
  cluster_id = "consul-cluster"
  hvn_id     = module.basic.hcp_hvn.hvn_id
  tier       = "development"
}
