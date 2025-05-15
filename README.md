# Broken Infrastructure Lab – AWS E-Commerce Simulation

This lab simulates an insecure and misconfigured e-commerce environment in AWS. It's designed to showcase your ability to identify, diagnose, and repair real-world infrastructure issues using Terraform.

## Purpose

This isn't a copy-paste tutorial. It's a real troubleshooting lab that proves you can:

- Deploy live AWS infrastructure using Terraform
- Spot critical misconfigurations and security flaws
- Debug infrastructure like a Cloud or DevOps Engineer
- Document and fix issues systematically

## Broken on Purpose

| Layer          | What's Broken                                | Why It Matters                                  |
|----------------|----------------------------------------------|-------------------------------------------------|
| EC2            | Flask app doesn't run                        | Simulates failed `user_data`                    |
| Security Group | Wide-open access to all ports                | Mirrors real-world attack vectors               |
| IAM Role       | Wildcard admin access (`*:*`)                | Shows poor permissions hygiene                  |
| S3 Bucket      | Previously insecure name and deprecated ACLs | Demonstrates S3 security config awareness       |
| SSH Access     | No key pair provisioned                      | Forces use of observability tools (CloudWatch)  |

## Tech Stack

- **AWS**: EC2, S3, VPC, IAM, Security Groups  
- **IaC**: Terraform  
- **Scripting**: Bash  
- **App**: Python (Flask)  
- **Debug Tools**: Optional CloudWatch + EC2 logs  

## Architecture Overview

Terraform provisions:
- A public VPC subnet
- An EC2 instance running a broken Flask app
- An isolated S3 bucket
- An overly permissive IAM role

## Fix & Investigate

- Why isn’t the Flask app responding on port 5000?
- How would you enable secure SSH access and install CloudWatch Agent?
- Refactor the IAM role for least privilege — what’s the minimal policy needed?
- Could ALB or Route 53 improve traffic control?
- How would you modularize this with reusable Terraform modules?

## Folder Structure

```
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── app/
│   └── app.py
│   └── requirements.txt
├── scripts/
│   └── debug.sh
├── README.md
└── .gitignore
```

## How to Deploy

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Grab the public IP from the Terraform output and test port 5000.

---

### Author

**Steven Lewis**  
Cloud Engineer | AWS Certified | Terraform, DevOps, Security  
GitHub: [sjlewis25](https://github.com/sjlewis25)

> This lab intentionally breaks things—so you can prove you know how to fix them.
