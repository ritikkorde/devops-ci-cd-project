pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "dockerrk11/my-app"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', 
                    credentialsId: 'github-credentials', 
                    url: 'https://github.com/ritikkorde/devops-ci-cd-project.git'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build --pull -t $DOCKER_HUB_REPO:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker push $DOCKER_HUB_REPO:latest"
                }
            }
        }

        stage('AWS EKS Kubeconfig') {
            steps {
                script {
                    // Use the AWS credentials for EKS access
                    withAWS(credentials: 'aws-credentials') {
                        sh """
                        aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
                        kubectl apply -f k8s-deployment.yaml
                        kubectl apply -f k8s-service.yaml
                        """
                    }
                }
            }
        }
    }
}
