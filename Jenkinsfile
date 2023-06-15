pipeline{
	agent any
	tools {
		terraform 'terraform-version-12'
	}
	stages{
        stage('Checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akramewu/terraform-cicd-pipeline.git']]])
            }
        }
		stage('Terraform Init'){
			steps{
				sh label: '', script: 'terraform init'
			}
		}
		stage('Terraform plan'){
			steps{
				sh label: '', script: 'terraform plan'
			}
		}
		stage('Terraform apply'){
			steps{
                echo "Terraform action is ---> apply"
				sh label: '', script: 'terraform apply --auto-approve'
			}
		}
	}
}