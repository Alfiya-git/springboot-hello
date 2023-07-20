pipeline {
    agent any 
    tools {
        maven "3.8.5"
    
    }
    stages {
        stage('Compile and Clean') { 
            steps {
                // Run Maven on a Unix agent.
              
                sh "mvn clean compile"
            }
        }
        stage('deploy') { 
            
            steps {
                sh "mvn package"
            }
        }
        stage('Build Docker image'){
          
            steps {
                echo "Hello Java Express"
                sh 'ls'
                sh 'docker build -t docker_jenkins_springboot:${BUILD_NUMBER} .'
            }
        }
        stage('Docker Login'){
            
            steps {
                 withCredentials([usernamePassword(credentialsId: 'DockerId', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                }
            }                
        }
        stage('Docker Push'){
            steps {
                sh 'docker push docker_jenkins_springboot:${BUILD_NUMBER}'
            }
        }
        stage('Docker deploy'){
            steps {
               
                sh 'docker run -itd -p  8081:8081 docker_jenkins_springboot:${BUILD_NUMBER}'
            }
        }
        stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}

