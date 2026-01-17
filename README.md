# Terraform AWS Infrastructure Project

## Overview
This project provisions AWS infrastructure using Terraform.
It creates a secure, scalable environment with networking, compute, storage, and database layers.

### Prerequisites
- AWS CLI to be installed: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Terraform to be installed: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- AWS credentials configured (aws configure)

### Folder Structure

### Infrastructure Components
- **VPC** - custom VPC with CIDR 10.0.0.0/16
- **Subnets** - two public and two private subnets across us-east-1a and us-east-1b
- **Internet Gateway & Route Tables** - to enable public internet access
- **Security Groups** - for EC2, Load Balancer and RDS
- **EC2 instance** - Ubuntu instance (t2.micro) for application hosting
- **RDS PostgreSQL database** - database hosted in private subnets
- **Application Load Balancer (ALB)** - distributes traffic to EC2 target group
- **S3 bucket** - for Terraform state storage and backups
- **DynamoDB table** - for state file locking (prevents conflicts during apply)

### Architecture Decision Highlights
- **Modular Design** — logically separated files: main.tf, variable.tf, output.tf, backend.tf, provider.tf.
- **Backend Configuration** — used S3 for remote state and DynamoDB for locking.
- **Multi-AZ Setup** — subnets spread across two availability zones for HA (us-east-1a & 1b).
- **Public–Private Isolation** — app hosted in public subnet; DB isolated in private subnets.
- **Load Balancing** — used Application Load Balancer (Layer 7) for scalability.

### Security Considerations
- **SSH (22) and HTTP (80)** are open to all (0.0.0.0/0) for demo and testing purposes.
- **RDS** instance is created inside **private subnets and not publicly accessible** (publicly_accessible = false).
- **Terraform state** is stored securely in an S3 bucket with encryption enabled and DynamoDB lock table for safe remote backend management.
- **Security Groups** are applied to control traffic between ALB, EC2, and RDS resources.
- **No hardcoded IAM** users or roles — the setup relies on AWS CLI credentials configured on the system.
- **Database credentials** are stored in variables.tf for simplicity (can be later moved to AWS Secrets Manager).

### Cost Optimization Measures
- Used **t2.micro and db.t3.micro** (free-tier eligible).
- Created **small storage (10 GB**) for RDS to minimize cost.
- Only essential networking, compute, and database resources deployed.
- Run **terraform destroy** after testing to avoid ongoing costs.

### Setup and Deployment
**Step 1 – Clone the Repository**
- git clone https://github.com/vishalab26/Terraform-AWS-Infrastructure.git
- cd terraform-infra

**Step 2 – Initialize Terraform**
- terraform init

**Step 3 – Validate Configuration**
- terraform validate

**Step 4 – Review Execution Plan**
- terraform plan

**Step 5 – Apply to Create Infrastructure**
- terraform apply

**Step 6 – Destroy Infrastructure (optional)**
- terraform destroy

### Outputs
After running terraform apply, Terraform prints the following:

### References
The following official Terraform and AWS documentation resources were referred to while building this infrastructure:
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
- https://developer.hashicorp.com/terraform/language/backend/s3
- https://developer.hashicorp.com/terraform/language/block/variable
- https://developer.hashicorp.com/terraform/language/block/output
