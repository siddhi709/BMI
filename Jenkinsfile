pipeline {
    agent any

    environment {
        DEPLOY_DIR = '/var/www/html'
        GITHUB_REPO = 'https://github.com/siddhi709/BMI.git'
        BRANCH = 'main'
        CREDENTIALS_ID = 'github-credentials'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${BRANCH}", url: "${GITHUB_REPO}", credentialsId: "${CREDENTIALS_ID}"
            }
        }

        stage('Install Apache') {
    steps {
        sh '''
            echo "Shidhhi@123" | sudo -S apt update
            echo "Shidhhi@123" | sudo -S apt install -y apache2
        '''
    }
}


        stage('Clean Deploy Directory') {
            steps {
                sh 'sudo rm -rf ${DEPLOY_DIR}/*'
            }
        }

        stage('Deploy Site') {
            steps {
                sh 'sudo cp -r * ${DEPLOY_DIR}/'
            }
        }

        stage('Post Deployment Test') {
            steps {
                script {
                    def status = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost", returnStdout: true).trim()
                    if (status != '200') {
                        error("Deployment failed! HTTP status: ${status}")
                    }
                }
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}

