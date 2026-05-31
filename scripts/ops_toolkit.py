"""
ops_toolkit.py - CloudShelf infrastructure audit script.
Audits EC2, Security Groups, and RDS for misconfigurations.

Usage:
python3 ops_toolkit.py
"""

import boto3
import sys
from datetime import datetime, timezone
from list_instances import list_cloudshelf_instances
from audit_security_groups import audit_security_groups
from utils import ok, warn, risk, header, REGION, BOLD, RESET

def run_list_instances():
    header("EC2 Instances")
    list_cloudshelf_instances()

if __name__ == "__main__":
    print(f"{BOLD}CloudShelf Ops Toolkit{RESET} — {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    run_list_instances()
    audit_security_groups()