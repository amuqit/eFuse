pipeline {
    agent any

    stages {
        stage ('Clone Terraform Repo') {
            steps {
                echo 'Hello World'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/aws-ia/terraform-aws-eks-blueprints.git']]])
                        }}
        stage ('Terraform provision') {
            steps {
                sh """
                    cd examples/eks-cluster-with-new-vpc/
                    terraform init
                    export AWS_REGION=us-west-2
                    terraform plan
                    terraform apply --auto-approve
                """
            }
        }
        stage ('License to Kill?') {
            steps {
                input message: 'Destroy terraform resources?'
            }
        }
        stage ('Search and Destroy') {
            steps {
                sh 'cd examples/eks-cluster-with-new-vpc/; terraform destroy --auto-approve'
                
            }
        }
    }
}