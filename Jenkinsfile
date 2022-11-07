pipeline{
    agent any
    stages{
        stage("sonar quality"){
            steps{
                script{
                    def scannerHome = tool 'sonarqube-scanner';
                    withSonarQubeEnv('My SonarQube Server') { 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
