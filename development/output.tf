output "all_vpcs_private_subnets" {
  description = "Private Subnet CIDRs for all created VPCs"
  value = {
    for name, vpc_mod in module.multi_vpc : name => vpc_mod.private_subnet_cidr_block
  }
}