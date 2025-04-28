pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ashparshpandey/todo-api-go'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ashparshp/todo-api-go.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image("${DOCKER_IMAGE}").push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}").run('-d -p 8080:8080')
                }
            }
        }
    }
}
