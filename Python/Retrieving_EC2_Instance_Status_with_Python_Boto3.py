# EC2 Instance Status
import boto3
import os

region_name = 'ap-south-1'  # Change to your desired region

# EC2 client
ec2_client = boto3.client('ec2', region_name=region_name)

user_input = input("Enter the Input file with path: ")


if os.path.exists(user_input):
    print(f"{user_input} file exists ")
    with open(user_input, 'r') as file:
        instance_ids = file.read().splitlines()
    # # For Each instance
    for instance_id in instance_ids:
        # Describe the instance
        response = ec2_client.describe_instances(InstanceIds=[instance_id])
        # Extract the instance state from the response
        instance_state = response['Reservations'][0]['Instances'][0]['State']['Name']
        # Print the instance state
        print(f"Instance ID: {instance_id}; State: {instance_state}")

else:
  print(f"{user_input} file does not exist")
