pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "batch23appnew"
        DOCKER_REGISTRY = "psrv3"
        IMAGE_TAG = "${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/iampsrv/simplivapp.git'
            }
        }

        stage('Setup') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install flask pytest
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . .venv/bin/activate
                    pytest
                '''
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh """
                        docker login -u psrv3 -p ${dockerhubpwd}
                    """
                }
                echo 'Login successfully'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${IMAGE_TAG} .
                """
                echo "Docker image built successfully"
                sh "docker images"
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push ${IMAGE_TAG}"
                echo "Docker image pushed successfully"
            }
        }
    }
}
