pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    environment {
        DEPLOY_DIR = "/opt/prod-docker-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ORG_NAME/REPO_NAME.git'
            }
        }

        stage('Prepare Deploy Directory') {
            steps {
                sh '''
                  sudo mkdir -p /opt/prod-docker-app
                  sudo rsync -av --delete ./ /opt/prod-docker-app/
                '''
            }
        }

        stage('Build Docker Images') {
            steps {
                dir('/opt/prod-docker-app') {
                    sh 'docker compose build'
                }
            }
        }

        stage('Deploy Containers') {
            steps {
                dir('/opt/prod-docker-app') {
                    sh '''
                      docker compose down
                      docker compose up -d
                    '''
                }
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                  sleep 10
                  curl -f http://localhost || exit 1
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful"
        }
        failure {
            echo "❌ Deployment failed"
        }
        always {
            sh 'docker system prune -f'
        }
    }
}
