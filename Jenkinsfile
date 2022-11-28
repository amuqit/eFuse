// Note: Fix plug-in to run kubectl commands from Jenkins directly!

pipeline {
    agent any

    stages {

        stage ('Clone Terraform Repo') {
            steps {
                echo 'Hello World'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/amuqit/eFuse.git']]])
        }}
        
        stage ('Deploy Amazon EKS Cluster using EKSCTL commands') {
            steps {
                sh 'eksctl create cluster --name=attractive-gopher'
                sh 'eksctl utils associate-iam-oidc-provider --cluster=attractive-gopher --approve'
                
            }
        }

        stage ('Deploy AWS ALB Ingress Controller') {
            steps {
                sh 'kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml'

                sh 'aws iam create-policy \
                        --policy-name ALBIngressControllerIAMPolicy \
                        --policy-document https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/iam-policy.json'
                
                sh 'eksctl create iamserviceaccount \
                        --cluster=attractive-gopher \
                        --namespace=kube-system \
                        --name=alb-ingress-controller \
                        --attach-policy-arn=$PolicyARN \
                        --override-existing-serviceaccounts \
                        --approve'

                sh 'curl -sS "https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/alb-ingress-controller.yaml" \
                        | sed "s/# - --cluster-name=devCluster/- --cluster-name=attractive-gopher/g" \
                        | kubectl apply -f -' 
            }
        }
        
        stage ('Deploy Applications') {
            steps {
                sh 'cd eFuse/'
                sh 'kubectl apply -f namespace.yaml'
                sh 'kubectl apply -f 2048-deployment.yaml'
                sh 'kubectl apply -f 2048-service.yaml'
                sh 'kubectl apply -f nginx_deployment.yaml'
                sh 'kubectl apply -f nginx-service.yaml'
            }

        }
        
        stage ('Deploy Ingress') {
            steps {
                sh 'kubectl apply -f final_ingress.yaml'
            }

        }
        
        stage ('Test Ingress') {
            steps {
                sh 'kubectl get ingress/2048-ingress -n 2048-game'
            }

        }


        
    }
}