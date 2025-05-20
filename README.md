# Broken Infrastructure Lab (AWS + Terraform)

## Overview

This project simulates inheriting broken cloud infrastructure—a scenario cloud engineers face all the time. The goal is to diagnose, document, and fix misconfigured AWS resources using Terraform, like a cloud forensic specialist.

It reflects a real-world challenge: joining a team mid-project and making sense of unclear, broken, or insecure environments.

---

## The Scenario: What Was Broken?

I intentionally built an AWS stack with the following issues:

- **Misconfigured security groups** (overly open ports)
- **IAM role with over-permissive policies**
- **EC2 instance not in a private subnet**
- **RDS instance publicly accessible**
- **Terraform state drift** (manual AWS console edits)
- **No monitoring or logging enabled**

These represent common, high-risk mistakes in early-stage cloud projects.

---

## My Approach

1. **Cloned the repo** and reviewed the existing Terraform configuration
2. **Compared state vs actual AWS environment** to identify drift
3. **Used AWS CLI and Console tools** (VPC flow logs, CloudTrail, IAM Access Analyzer)
4. **Diagnosed each misconfiguration** with specific security and performance risks
5. **Refactored Terraform code** to:
   - Lock down security groups
   - Move EC2/RDS to private subnets
   - Enforce IAM least privilege
   - Enable CloudWatch logs and alarms
6. **Applied fixes with Terraform**, verified infrastructure health

---


## Key AWS Services Used

- **VPC, Subnets, Route Tables**
- **EC2, RDS**
- **IAM roles and policies**
- **CloudWatch for monitoring**
- **Terraform for infra as code**

---

## What I Fixed (Before → After)

| Issue | Before | After |
|------|--------|-------|
| Security Groups | Open to 0.0.0.0/0 | Scoped to internal traffic only |
| IAM Policy | AdministratorAccess | Custom role with least privilege |
| EC2 | Public subnet | Moved to private subnet with NAT access |
| RDS | Publicly accessible | Private, encrypted, subnet group applied |
| Monitoring | Disabled | CloudWatch logs and alarms enabled |
| Terraform Drift | Yes | State realigned with `terraform import` and cleanup |

---

## Lessons Learned

- How to detect and reverse Terraform state drift
- How small misconfigurations can introduce serious vulnerabilities
- The value of IaC in maintaining consistent, secure environments
- Real-world debugging skills beyond just “building from scratch”

---

## Future Enhancements

- Add AWS Config and Inspector for continuous compliance
- Add automated security scanning with Checkov or tfsec
- Simulate more complex failure scenarios (e.g. broken CI/CD pipelines)

---

## How to Use This Lab

1. Clone the repo:
```bash
git clone https://github.com/sjlewis25/broken-infra-lab.git
cd broken-infra-lab
```

2. Review the `main.tf` and try to spot what’s broken

3. Deploy the original setup (dev/test AWS account recommended):
```bash
terraform init
terraform apply
```

4. Read the `FIX_REPORT.md` for step-by-step fixes

5. Apply corrected infra:
```bash
cd fixed/
terraform init
terraform apply
```

---

## Author

**Steven Lewis**  
Cloud Engineer | AWS | Terraform | Infra Recovery & Security  
[GitHub](https://github.com/sjlewis25)

