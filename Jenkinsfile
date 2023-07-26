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
        stage('deploy') { 
            
            steps {
                sh "mvn package"
            }
        }
        
        
           stage('Push to ECR') {
            steps {
                sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 939238552155.dkr.ecr.us-east-2.amazonaws.com"
                sh 'docker build -t jenkins_springboot:${BUILD_NUMBER} .'
                sh "docker push 939238552155.dkr.ecr.us-east-2.amazonaws.com/test:latest"
            }
        }
    
    }
}

