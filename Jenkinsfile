pipeline{
    agent any
    stages{
        stage("sonar quality"){
            def scannerHome = tool 'SonarScanner 4.0';
            withSonarQubeEnv(credentialsId: 'sonar-token') { 
                sh "${scannerHome}/bin/sonar-scanner"
            }
        }
    }
}
