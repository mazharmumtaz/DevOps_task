pipeline {
    agent any

    stages {
        stage('Test') {
            when {
                beforeAgent true
                expression { currentBuild.changeSets != null && currentBuild.changeSets.size() > 0 }
            }
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }

        stage('Build') {
            when {
                beforeAgent true
                allOf {
                    not { currentBuild.result == 'FAILURE' }
                    expression { currentBuild.changeSets != null && currentBuild.changeSets.size() > 0 }
                }
            }
            steps {
                echo 'Building Docker image...'
                // Add your Docker build and push commands here
            }
        }

        stage('Deploy') {
            when {
                beforeAgent true
                allOf {
                    not { currentBuild.result == 'FAILURE' }
                    expression { currentBuild.changeSets != null && currentBuild.changeSets.size() > 0 }
                }
            }
            steps {
                echo 'Deploying to EKS using Helm...'
                // Add your Helm deployment commands here
            }
        }
    }
}
