import boto3
from utils import ok, warn, risk, header, REGION, BOLD, RESET
from datetime import datetime, timezone

# ── 2. Audit Security Groups ────────────────────────────────────────────────

RISKY_PORTS = {
    22:   "SSH",
    3306: "MySQL",
    5432: "Postgres",
    3389: "RDP",
    27017: "MongoDB",
}

# Ports intentionally open to the public
ALLOWED_PUBLIC_PORTS = {80, 443}

def audit_security_groups():
    header("Security Group Audit")
    ec2 = boto3.client("ec2", region_name=REGION)

    response = ec2.describe_security_groups(
        Filters=[{"Name": "tag:Project", "Values": ["cloudshelf"]}]
    )

    sgs = response["SecurityGroups"]
    if not sgs:
        warn("No security groups tagged Project=cloudshelf found")
        return

    for sg in sgs:
        sg_name = sg["GroupName"]
        sg_id   = sg["GroupId"]
        print(f"\n  SG: {sg_name} ({sg_id})")
        findings = 0

        for rule in sg["IpPermissions"]:
            from_port = rule.get("FromPort", 0)
            to_port   = rule.get("ToPort", 65535)

            # Collect all CIDR ranges in this rule (IPv4 and IPv6)
            open_cidrs = (
                [r["CidrIp"] for r in rule.get("IpRanges", [])] +
                [r["CidrIpv6"] for r in rule.get("Ipv6Ranges", [])]
            )

            for cidr in open_cidrs:
                if cidr in ("0.0.0.0/0", "::/0"):
                    # Check if any risky port falls within this rule's port range
                    for port, service in RISKY_PORTS.items():
                        if from_port <= port <= to_port:
                            risk(f"Port {port} ({service}) open to {cidr} — EXPOSED")
                            findings += 1

                    # Flag any other wildcard rule even if port not in RISKY_PORTS
                    if not any(from_port <= p <= to_port for p in RISKY_PORTS):
                        if any(from_port <= p <= to_port for p in ALLOWED_PUBLIC_PORTS):
                                    ok(f"Port range {from_port}–{to_port} open to {cidr} — intentionally public")
                        else:
                            warn(f"Port range {from_port}–{to_port} open to {cidr} — review recommended")
                            findings += 1
                        
        if findings == 0:
            ok("No wildcard inbound rules detected")

if __name__ == "__main__":
    print(f"{BOLD}cloudshelf Ops Toolkit{RESET} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    audit_security_groups()