# eFuse


Plan and Execution: 

1: Install Jenkins on EC2 - linux server  (One time manual setup)
2: Using the Jenkins Dashboard (EC2) - create a Jenkins Job to pick the JenkinsFile from the repo
    Added Pre-reqs: Installed Git, AWS CLI, Terraform and HELM - One time solution.
    
3: Jenkinsfile - will trigger EKS cluster creation using AWS provided Terraform Template
4: Install NGINX ingress controller - on one node

