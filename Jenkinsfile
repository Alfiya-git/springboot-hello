pipeline {
    agent any 
    
    environment {
            // POM_VERSION = getVersion()
            // JAR_NAME = getJarName()
            AWS_ECR_REGION = 'us-east-2'
            AWS_ECS_SERVICE = 'springboot-service'
            AWS_ECS_TASK_DEFINITION = 'springboot-taskDef'
            AWS_ECS_COMPATIBILITY = 'FARGATE'
            AWS_ECS_NETWORK_MODE = 'Alfiya-VPC'
            AWS_ECS_CPU = '256'
            AWS_ECS_MEMORY = '512'
            AWS_ECS_CLUSTER = 'project'
            AWS_ECS_TASK_DEFINITION_PATH = './ecs/container-definition-update-image.json'
            }
    
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
            
     stage('Deploy in ECS') {
            steps {
 withCredentials([awsSecretManager(credentialsId: 'AWS_EXECUTION_ROL_SECRET', secretId: 'your-secret-id')]) {
                         script {
                        updateContainerDefinitionJsonWithImageVersion()
                        sh("/usr/local/bin/aws ecs register-task-definition --region ${AWS_ECR_REGION} --family ${AWS_ECS_TASK_DEFINITION} --execution-role-arn ${AWS_ECS_EXECUTION_ROL} --requires-compatibilities ${AWS_ECS_COMPATIBILITY} --network-mode ${AWS_ECS_NETWORK_MODE} --cpu ${AWS_ECS_CPU} --memory ${AWS_ECS_MEMORY} --container-definitions file://${AWS_ECS_TASK_DEFINITION_PATH}")
                        def taskRevision = sh(script: "/usr/local/bin/aws ecs describe-task-definition --task-definition ${AWS_ECS_TASK_DEFINITION} | egrep \"revision\" | tr \"/\" \" \" | awk '{print \$2}' | sed 's/\"\$//'", returnStdout: true)
                        sh("/usr/local/bin/aws ecs update-service --cluster ${AWS_ECS_CLUSTER} --service ${AWS_ECS_SERVICE} --task-definition ${AWS_ECS_TASK_DEFINITION}:${taskRevision}")
                    }
                 }
    }
}
    }
}
