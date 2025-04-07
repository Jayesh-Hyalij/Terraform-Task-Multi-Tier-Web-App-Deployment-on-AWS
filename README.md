# Terraform-Task-Multi-Tier-Web-App-Deployment-on-AWS

Overview
This project sets up a custom Virtual Private Cloud (VPC) on AWS using Terraform. The architecture includes:

- A VPC with 2 public and 2 private subnets (spread across two Availability Zones)
- Internet Gateway and proper route table configurations
- EC2 Instances:
  - Web Server (NGINX) in public subnets
  - Database Server (MySQL/Postgres) in private subnets
- Security Groups for controlled access
- Modularized Terraform code for reusability and scalability

-        Architecture Diagram
-                        +----------------------+
                         |      Internet        |
                         +----------+-----------+
                                    |
                         +----------v-----------+
                         |    Internet Gateway   |
                         +----------+-----------+
                                    |
                   +-----------------------------+
                   |           Route Table       |
                   +-----------------------------+
                     |                       |
     +--------------------------+   +--------------------------+
     |     Public Subnet 1      |   |     Public Subnet 2      |
     |     (AZ-a)               |   |     (AZ-b)               |
     |  EC2: Web Server (NGINX) |   |  EC2: Web Server (NGINX) |
     +--------------------------+   +--------------------------+
                     |                       |
             +----------------+     +----------------+
             | Web SG: Allow  |     | Web SG: Allow  |
             | 80, 22 from IP |     | 80, 22 from IP |
             +----------------+     +----------------+
                     |                       |
         +------------------+     +-------------------+
         | Private Subnet 1 |     | Private Subnet 2  |
         |   (AZ-a)         |     |   (AZ-b)          |
         | EC2: DB (MySQL)  |     | EC2: DB (Postgres)|
         +------------------+     +-------------------+
                     |                       |
             +----------------+     +----------------+
             | DB SG: Allow   |     | DB SG: Allow   |
             | 3306 from Web  |     | 5432 from Web  |
             +----------------+     +----------------+


## Modules
1. VPC Module
Creates a VPC with:
  - CIDR block
  - Internet Gateway
  - Public and private subnets in two Availability Zones
  - Route tables with associations

Inputs:
  - VPC CIDR
  - Subnet CIDRs
  - AZs

2. EC2 Module
Launches EC2 instances:
  - AMI ID, instance type, subnet, key pair
  - User data script for NGINX/DB setup

Inputs:
  - Instance type
  - Subnet ID
  - Security Group ID
  - User data script

3. Security Groups Module
Defines:
  - Web SG: HTTP (80), SSH (22) from your IP
  - DB SG: MySQL (3306) or Postgres (5432) allowed only from Web SG

Inputs:
  - Ingress/egress rules
  - Source SG or IP

Execution Steps
1. Initialize and Apply
    -- terraform init
    -- terraform plan
    -- terraform apply

3. Expected Output
  - Public EC2 with NGINX accessible on port 80
  - Private EC2 with MySQL/Postgres accessible only from web EC2
  - All resources created using modularized Terraform code


### File Structure

      terraform-project/
      │
      ├── main.tf
      │
      ├── modules/
      │   ├── vpc/
      │   │   └── main.tf
      │   │   └── variables.tf
      │   │   └── outputs.tf
      │   ├── ec2/
      │   │   └── main.tf
      │   │   └── variables.tf
      │   │   └── outputs.tf
      │   └── security-groups/
      │       └── main.tf
      │       └── variables.tf
      │       └── outputs.tf


Notes
  - Ensure your AWS CLI is configured.
  - Replace AMI IDs and IPs with region-specific and authorized values.
  - Use terraform destroy to tear down the setup after use.

