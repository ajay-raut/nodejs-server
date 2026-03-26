pipeline {
    agent {
        node {
            label 'builtinubuntu'
        }
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    environment {
        DOCKER_HUB = credentials('docker-hub-credentials')
        // Define your Docker Hub username and Repo name here for easy updates
        DOCKER_REPO = "ajay25/nodejs-server"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ajay-raut/nodejs-server.git'
            }
        }

        stage('Docker Login') {
            steps {
                sh "echo \"${DOCKER_HUB_PSW}\" | docker login -u \"${DOCKER_HUB_USR}\" --password-stdin"
            }
        }

        stage('Docker Build') {
            steps {
                // Build with the full repository name and Build ID for versioning
                sh "docker build -t ${DOCKER_REPO}:${env.BUILD_ID} ."
                sh "docker tag ${DOCKER_REPO}:${env.BUILD_ID} ${DOCKER_REPO}:latest"
            }
        }

        stage('Docker Push') {
            steps {
                // Push both the specific Build ID tag and the 'latest' tag
                sh "docker push ${DOCKER_REPO}:${env.BUILD_ID}"
                sh "docker push ${DOCKER_REPO}:latest"
            }
        }

        stage('Docker Run') {
            steps {
                // Run the newly pushed image
                sh "docker run --name node-container -p 3003:3003 -d ${DOCKER_REPO}:latest"
            }
        }

        stage('Docker Cleanup') {
            steps {
                sh """
                docker logout
                docker stop node-container || true
                docker rm node-container || true
                docker rmi ${DOCKER_REPO}:${env.BUILD_ID} || true
                docker rmi ${DOCKER_REPO}:latest || true
                """
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution finished.'
            sh "echo 'Current Job: ${env.JOB_NAME} - ID: ${env.BUILD_ID}'"
        }
    }
}