pipeline {
    agent any

    stages {
        stage ('Clone Terraform Repo') {
            steps {
                echo 'Hello World'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/aws-ia/terraform-aws-eks-blueprints.git']]])
                        }}
        stage ('Running Kubectl command') {
            steps {
                sh """
                    sh 'kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml'
                """
            }
        }
    }
}