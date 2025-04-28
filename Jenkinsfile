pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ashparshpandey/todo-api-go'
        DOCKERHUB_USERNAME = credentials('dockerhub-username')
        DOCKERHUB_PASSWORD = credentials('dockerhub-password')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ashparshp/todo-api-go.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    sh '''
                        echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if running
                    sh '''
                        docker rm -f todo-api-go-container || true
                    '''
                    // Run new container
                    sh '''
                        docker run -d --name todo-api-go-container -p 8080:8080 $DOCKER_IMAGE
                    '''
                }
            }
        }
    }
}