pipeline{
	agent any
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
                echo "Terraform action is ---> plan"
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