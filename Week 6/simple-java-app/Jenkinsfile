pipeline {
    agent any

    tools {
        maven 'Maven 3.8.6'   // Set this in Jenkins Global Tool Configuration
    }

    stages {
        stage('Checkout') {
            steps {
                git "https://github.com/iampsrv/javajenkins.git"
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Run') {
            steps {
                sh 'java -cp target/simple-java-app-1.0-SNAPSHOT.jar com.example.App'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }
}
