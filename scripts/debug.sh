#!/bin/bash
echo "Running Broken Infrastructure Debug Script..."

# Check EC2 metadata
curl -s http://169.254.169.254/latest/meta-data/

# Check public IP exposure
curl ifconfig.me

# List environment variables (bad practice)
env
