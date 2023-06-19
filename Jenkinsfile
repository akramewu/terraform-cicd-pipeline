pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: '308e2027-1806-4707-8315-370d442691f9', url: 'https://github.com/akramewu/terraform-cicd-pipeline.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh label: '', script: 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps {
                echo 'Terraform action is ---> Validate'
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Terraform action is ---> Plan'
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                echo 'Terraform action is ---> apply'
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
