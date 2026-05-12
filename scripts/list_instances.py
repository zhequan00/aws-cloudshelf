import boto3

def list_cloudshelf_instances():
    ec2 = boto3.client("ec2", region_name="ap-southeast-1")
    
    response = ec2.describe_instances(
        Filters=[{"Name": "tag:Project", "Values": ["CloudShelf"]}]
    )
    
    instances = []
    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            name = next(
                (tag["Value"] for tag in instance.get("Tags", []) if tag["Key"] == "Name"),
                "unnamed"
            )
            instances.append({
                "name": name,
                "state": instance["State"]["Name"],
                "public_ip": instance.get("PublicIpAddress", "N/A"),
            })
    
    if not instances:
        print("No CloudShelf instances found.")
        return
        
    for i in instances:
        print(f"{i['name']} | {i['state']} | {i['public_ip']}")

if __name__ == "__main__":
    list_cloudshelf_instances()