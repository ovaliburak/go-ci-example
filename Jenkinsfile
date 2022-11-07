pipeline{
    agent any
    stages{
        stage('Static Code Analysis'){
        withSonarQubeEnv('sonarqube') {
            sh 'sonar-scanner'
            }
        }
        
    }
}
