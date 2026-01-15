pipeline {
    agent any

    environment {
        DEPLOY_DIR = "/opt/prod-docker-app"
        COMPOSE_FILE = "docker-compose.yml"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Manish636700/assignment-test.git'
            }
        }

        stage('Prepare Deployment Directory') {
            steps {
                sh """
                    sudo mkdir -p ${DEPLOY_DIR}
                    sudo rsync -av --delete ./ ${DEPLOY_DIR}/
                """
            }
        }

        stage('Build Docker Images') {
            steps {
                dir("${DEPLOY_DIR}") {
                    sh """
                        docker-compose build
                    """
                }
            }
        }

        stage('Deploy Containers') {
            steps {
                dir("${DEPLOY_DIR}") {
                    sh """
                        docker-compose down
                        docker-compose up -d
                    """
                }
            }
        }


        stage('Health Check') {
            steps {
                sh '''
                    sleep 15
                    curl -f http://localhost || exit 1
                '''
            }
        }
    }

    post {
        success {
            echo "Production deployment successful"
        }
        failure {
            echo "Deployment faild"
            sh "docker-compose down"
        }

        always {
            sh "docker system prune -f"
        }
    }

}