# Challenges Faced

## Challenge
Initially confused about whether a custom VPC was required to launch an EC2 instance.

## Resolution
Learned that AWS provides a default VPC and default subnets which can be used
for quick testing and learning purposes. Used Terraform data sources to fetch
the default VPC and subnet dynamically.

