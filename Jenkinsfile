pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                script {
                    dir('terraform')
                    /* groovylint-disable-next-line NestedBlockDepth */
                    {
                        git branch: 'main', credentialsId: '308e2027-1806-4707-8315-370d442691f9', url: 'https://github.com/akramewu/terraform-cicd-pipeline.git'
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'pwd;cd /jenkinsdata/azure-pipeline-akramul/workspace/terraform/ ; terraform init'
            }
        }
    /*
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
        */
    }
}
