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
                echo "Terraform action is ---> init"
                sh ('terraform init')
			}
		}
		stage('Terraform Validate'){
			steps{
                echo "Terraform action is ---> Validate"
				sh 'terraform validate'
			}
		}

        stage('Terraform Plan'){
			steps{
                echo "Terraform action is ---> Plan"
				sh 'terraform plan'
			}
		}
		stage('Terraform Apply'){
			steps{
                echo "Terraform action is ---> apply"
				sh 'terraform apply --auto-approve'
			}
		}
	}
}