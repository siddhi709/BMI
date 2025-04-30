pipeline {
    agent any

    environment {
        DEPLOY_DIR = '/var/www/html'
        GITHUB_REPO = 'https://github.com/siddhi709/BMI.git'
        BRANCH = 'main'
        CREDENTIALS_ID = 'github-credentials'
        SUDO_PASS = 'Shidhhi@123'
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
                    echo "${SUDO_PASS}" | sudo -S apt update
                    echo "${SUDO_PASS}" | sudo -S apt install -y apache2 curl
                '''
            }
        }

        stage('Clean Deploy Directory') {
            steps {
                sh 'echo "${SUDO_PASS}" | sudo -S rm -rf ${DEPLOY_DIR}/*'
            }
        }

        stage('Deploy Site') {
            steps {
                sh 'echo "${SUDO_PASS}" | sudo -S cp -r * ${DEPLOY_DIR}/'
            }
        }

        stage('Smoke Test') {
            steps {
                script {
                    def status = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost", returnStdout: true).trim()
                    if (status != '200') {
                        error("Deployment failed! HTTP status: ${status}")
                    }
                }
            }
        }

        stage('Functional UI Tests') {
            steps {
                sh '''
                    echo "🔍 Running UI tests on deployed BMI Calculator..."

                    # Test 1: Check page loads and contains main heading
                    curl -s http://localhost | grep -qi "Body Mass Index Calculator" || (echo "❌ Heading check failed" && exit 1)

                    # Test 2: Ensure form is present
                    curl -s http://localhost | grep -qi "<div class=\\"form\\"" || (echo "❌ Form container missing" && exit 1)

                    # Test 3: Check for Metric/Imperial radio buttons
                    curl -s http://localhost | grep -q 'type="radio"' || (echo "❌ Radio inputs not found" && exit 1)

                    # Test 4: Ensure result container exists
                    curl -s http://localhost | grep -qi "Your BMI is" || (echo "❌ BMI result text missing" && exit 1)

                    # Test 5: Check footer credits
                    curl -s http://localhost | grep -qi "Developed by Abinandh MJ" || (echo "❌ Footer credits missing" && exit 1)

                    echo "✅ All functional tests passed!"
                '''
            }
        }
    }

    post {
        success {
            echo '🎉 Deployment and all tests passed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check the console output for test failures.'
        }
    }
}
