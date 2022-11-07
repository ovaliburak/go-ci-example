pipeline{
    agent any
    stages{
        stage("sonar quality"){
            withSonarQubeEnv(credentialsId: 'sonar-token') {
               sh 'sonar-scanner'
            }
        }
    }
}
