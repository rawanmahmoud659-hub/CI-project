
pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Select the Terraform environment'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Workspace Select') {
            steps {
                sh '''
                    terraform workspace select "$ENVIRONMENT" ||
                    terraform workspace new "$ENVIRONMENT"
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan \
                      -var-file="${ENVIRONMENT}.tfvars" \
                      -out=tfplan
                '''
            }
        }

        stage('Approve') {
            steps {
                input message: "Approve Terraform apply for ${ENVIRONMENT}?",
                      ok: 'Approve'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline completed successfully!'
        }

        failure {
            echo 'Terraform pipeline failed. Check the console output.'
        }

        always {
            cleanWs()
        }
    }
}
