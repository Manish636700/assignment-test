pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-org/your-repo.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker compose build'
            }
        }

        stage('Deploy Containers') {
            steps {
                sh '''
                  docker compose down
                  docker compose up -d
                '''
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
        always {
            sh 'docker system prune -f'
        }
    }
}
