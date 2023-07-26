pipeline {
    agent any 
    
    tools {
        maven "3.8.5"
    }
    
    stages {
        stage('Compile and Clean') {
            steps {
                sh "mvn clean compile"
            }
        }
        
        stage('Package') {
            steps {
                sh "mvn package"
            }
        }
        
        stage('Push to ECR') {
            steps {
                script {
                    // Tag the built image with ECR repository URL and 'latest' tag
                    sh "docker build -t 939238552155.dkr.ecr.us-east-2.amazonaws.com ."
                    sh "docker tag test:latest 939238552155.dkr.ecr.us-east-2.amazonaws.com/test:latest"
                    
                    // Log in to ECR
                    sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 939238552155.dkr.ecr.us-east-2.amazonaws.com"
                    
                    // Push the tagged image to ECR
                    sh "docker push 939238552155.dkr.ecr.us-east-2.amazonaws.com/test:latest"
                }
            }
        }
    
    }
}
