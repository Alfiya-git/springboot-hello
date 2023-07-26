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
            
           stage('Deploy to Fargate') 
            {
                environment {
                AWS_REGION = 'your-aws-region'
                ECS_CLUSTER_NAME = 'your-ecs-cluster-name'
                SERVICE_NAME = 'your-ecs-service-name'
                TASK_DEFINITION_NAME = 'your-task-definition-name'
                CONTAINER_NAME = 'your-container-name'
                IMAGE_TAG = "${env.BUILD_ID}"
                }
                
            steps {
                // Update the task definition with the new Docker image version
                sh "aws ecs register-task-definition \
                    --region ${AWS_REGION} \
                    --family ${TASK_DEFINITION_NAME} \
                    --container-definitions '[{\"name\":\"${CONTAINER_NAME}\",\"image\":\"your-docker-repo/spring-angular-app:${IMAGE_TAG}\"}]'"

                // Update the service to use the latest task definition
                sh "aws ecs update-service \
                    --region ${AWS_REGION} \
                    --cluster ${ECS_CLUSTER_NAME} \
                    --service ${SERVICE_NAME} \
                    --task-definition ${TASK_DEFINITION_NAME}"
            }
        }
    
    }
}
