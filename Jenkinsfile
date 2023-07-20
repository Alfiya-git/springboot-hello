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
                sh 'docker build -t alfiyazabir05/docker_jenkins_springboot:${BUILD_NUMBER} .'
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DockerId', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        def dockerLoginCmd = "docker login -u ${DOCKER_USERNAME} --password-stdin"
                        sh "echo ${DOCKER_PASSWORD} | ${dockerLoginCmd}"
                    }
                }
            }
        }
        
        stage('Docker Push') {
            steps {
                sh "docker push alfiyazabir05/docker_jenkins_springboot:${BUILD_NUMBER}"
            }
        }
        stage('Docker deploy') {
            steps {
                sh "docker run -itd -p 8080:8080 alfiyazabir05/docker_jenkins_springboot:${BUILD_NUMBER}"
            }
        }
       stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}

