pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR-USERNAME/BMI-Calculator.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'sudo apt update && sudo apt install -y apache2'  // Install Apache (Optional)
            }
        }

        stage('Build') {
            steps {
                echo 'No build step needed for HTML/CSS/JS static site'
            }
        }

        stage('Deploy') {
            steps {
                sh 'cp -r * /var/www/html/'  // Deploy to Apache server
            }
        }

        stage('Post Deployment Test') {
            steps {
                script {
                    def response = sh(script: "curl -o /dev/null -s -w '%{http_code}' http://localhost", returnStdout: true).trim()
                    if (response != '200') {
                        error("Deployment failed! HTTP Response: ${response}")
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}
