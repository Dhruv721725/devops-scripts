pipeline {
    agent any

    environment {
        IMAGE_NAME = "jenkins-nginx"
        CONTAINER_NAME = "jenkins-nginx-test"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd docker
                docker build -t $IMAGE_NAME:$BUILD_NUMBER .
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                docker run -d -p 8086:80 --name $CONTAINER_NAME $IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }

        stage('Verify Container') {
            steps {
                sh '''
                sleep 3
                curl -f http://localhost:8086
                '''
            }
        }
    }

    post {
        always {
            sh '''
            docker rm -f $CONTAINER_NAME || true
            docker rmi $IMAGE_NAME:$BUILD_NUMBER || true
            '''
        }
    }
}
