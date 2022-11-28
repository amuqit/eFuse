# eFuse


Part 1 and 2:
Prereq: 
1: Install Jenkins agent on EC2 servers.
2: Attach Admin IAM role to EC2 server - for ease of use. Not recommended for general use!
3: Installed Git, AWS CLI, eksctl, Kubectl and Terraform - one time setup.
4: Using the Jenkins Dashboard (EC2) - create a Jenkins Job to pick the JenkinsFile from the repo
    
Solution: Creates EKS clsuter using series of eksctl and kubectl commands. 
Deploys 2 sample applications (2048 game and Nginx server) with ALB ingress controller.



Part 3:
1: Set-up Jenkins Agent same as above
2: Trigger pipeline using the Jenkins file provided in /Part3.

Solution: Creates a S3 bucket and IAM user with specific access/control policies for S3 that was created.


   

