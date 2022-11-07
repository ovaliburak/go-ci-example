pipeline{
    agent any
    stages{
        stage("sonar quality"){
            steps {
                withSonarQubeEnv(credentialsId: 'sonar-token') {
                sh 'sonar-scanner'
                }
            }
        }
    }
}
