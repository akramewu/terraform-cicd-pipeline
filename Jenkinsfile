pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: '308e2027-1806-4707-8315-370d442691f9', url: 'https://github.com/akramewu/terraform-cicd-pipeline.git'
            }
        }

        stage('Install Terraform') {
            steps {
                script {
                    def terraformVersion = '1.3.1'
                    def os = sh(returnStdout: true, script: 'uname -s').trim()
                    def arch = sh(returnStdout: true, script: 'uname -m').trim()

                    if (os == 'Linux' && arch == 'x86_64') {
                        sh "wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip"
                        sh "unzip terraform_${terraformVersion}_linux_amd64.zip"
                    } else if (os == 'Darwin' && arch == 'x86_64') {
                        sh "curl -O https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_darwin_amd64.zip"
                        sh "unzip terraform_${terraformVersion}_darwin_amd64.zip"
                    } else {
                        error("Unsupported platform: ${os} ${arch}")
                    }

                    sh 'chmod +x terraform'
                    sh 'mv terraform /usr/local/bin/terraform'
                    sh 'terraform version'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

    }
}

/*
post {
        always {
            cleanWs()
        }
    }
*/

