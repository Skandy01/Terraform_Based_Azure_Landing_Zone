# Terraform Azure Platform Foundation

> **A production-ready Azure infrastructure foundation built using Terraform**

---

## 🚀 Overview

This repository implements a **modular Azure platform foundation** using **Terraform**, intended to serve as the **base infrastructure layer** for hosting enterprise applications.

Rather than focusing on a single app, this project focuses on **how cloud platforms are actually designed in organizations**:
- Strong network isolation
- Reusable Terraform modules
- Clear separation between foundation and application layers
- Secure-by-default infrastructure

This repo can act as:
- A **core platform** for VM-based workloads
- A **base layer** beneath CI/CD-driven application deployments
- A real-world **Azure IaC** design

---

## 🏗️ Architecture Philosophy

The platform is designed around **enterprise best practices**:

- **Modular Terraform design** (each Azure resource is its own module)
- **Layered infrastructure**
  - Core network & security
  - Compute & load balancing
  - Shared services (Key Vault, Storage, SQL)
- **Environment-ready structure** (easily extendable to Dev / QA / Prod)
- **Platform-first thinking**, not app-first

This mirrors how **platform engineering teams** build reusable cloud foundations.

---

## 🧩 Infrastructure Components

### 🔐 Networking & Security
- Virtual Network (VNet)
- Multiple Subnets
- Network Security Groups (NSG)
- Subnet–NSG associations
- Public IPs
- Azure Bastion (secure VM access)

### ⚙️ Compute & Traffic
- Linux Virtual Machines
- Network Interfaces (NICs)
- Azure Load Balancer
  - Frontend IP
  - Backend Pool
  - Health Probes
  - Load Balancing Rules
  - VM–LB associations

### 🗄️ Platform Services
- Azure Key Vault
- Key Vault Secrets
- Azure SQL Server
- Azure SQL Database
- Storage Account

---

## 📁 Repository Structure

```text
terraform-azure-platform-foundation/
│
├── Modules/                 # Reusable Terraform modules
│   ├── RG/
│   ├── VNet/
│   ├── Subnet/
│   ├── NSG/
│   ├── Subnet_NSG_Association/
│   ├── PublicIP/
│   ├── NIC/
│   ├── VM/
│   ├── Bastion/
│   ├── LB_FrontendIP/
│   ├── LB_BackendPool/
│   ├── LB_Probe/
│   ├── LB_Rule/
│   ├── LB_VM_Association/
│   ├── Key_Vault/
│   ├── Key_Vault_Secret/
│   ├── Storage_Account/
│   ├── SQL_Server/
│   └── SQL_DB/
│
├── Infra_QA/                # Environment-level composition (QA example)
│   ├── main.tf
│   ├── data.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── provider.tf
│
├── .gitignore
└── README.md


🔁 How the Platform Is Composed

Modules define what a resource is

Infra_QA defines how modules are wired together

Dependencies are explicitly controlled using depends_on

Data sources are used to reference already-created resources cleanly

This separation allows:

Reuse across environments

Easier reviews

Safer changes

Cleaner CI/CD integration

🔐 Security Considerations

No secrets are hardcoded in Terraform code

Sensitive values are passed via variables

Key Vault is used for secret storage

Bastion removes the need for public SSH access

NSGs restrict traffic at subnet and NIC levels


👤 Author

Bhabya Bharti
DevOps Engineer | Azure | Terraform | CI/CD | Platform Engineering
