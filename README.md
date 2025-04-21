# 💣 Broken Infrastructure Lab – AWS E-Commerce Simulation

This is a purpose-built, real-world **troubleshooting lab** to showcase your ability to identify, diagnose, and fix broken cloud infrastructure. It simulates an insecure and unreliable e-commerce environment running on **AWS with Terraform**.

---

## 🎯 What’s the Point?

Hiring managers want more than “I followed a tutorial.” This project is built to show that you can:
- **Deploy real AWS resources with Terraform**
- **Spot intentional misconfigurations and security flaws**
- **Troubleshoot like a real Cloud/DevOps Engineer**
- **Document issues and solutions like a pro**

---

## 🧨 Broken Components (On Purpose)

| Layer              | What's Broken                                 | Why It Matters                     |
|-------------------|------------------------------------------------|------------------------------------|
| EC2               | Flask app doesn't run properly                 | Simulates failed `user_data`       |
| Security Group     | Wide-open access to all ports                 | Simulates real-world attack vector |
| IAM Role          | Admin access to everything (`*:*`)             | Demonstrates overprivileged access |
| S3 Bucket         | Now fixed: name was insecure, ACL deprecated  | Shows S3 configuration awareness   |
| SSH Access        | No key pair; can't debug directly              | Shows value of observability tools |

---

## 🔧 Tech Stack

- **AWS**: EC2, S3, VPC, IAM, Security Groups
- **IaC**: Terraform
- **Scripting**: Bash
- **App**: Python (Flask)
- **Debug Phase**: Optional CloudWatch + EC2 logs

---

## 🧱 Infrastructure Architecture

```
Terraform → VPC → Public Subnet → EC2 Instance (Broken Flask App)
                       ↓
                S3 Bucket (isolated)
                       ↓
                IAM Role (full permissions 😬)
```

---

## 🚨 Things to Investigate & Fix

- [ ] Why isn't the Flask app responding?
- [ ] Can you get SSH access securely and install CloudWatch Agent?
- [ ] How would you refactor the IAM role to least privilege?
- [ ] How would you use ALB or Route53 for better traffic control?
- [ ] Can you use Terraform modules to make this reusable?

---

## 📂 Folder Structure

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

---

## 🚀 How to Deploy

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Grab the public IP from Terraform outputs and try to access port 5000.

---

## 👨‍💻 Author

**Steven Lewis**  
Cloud Engineer | AWS Certified | Terraform, DevOps, Security  
GitHub: [sjlewis25](https://github.com/sjlewis25)

---

> This lab breaks everything — so you can prove you know how to fix anything.
