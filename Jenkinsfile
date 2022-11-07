pipeline{
    agent any
    stages{
        stage("sonar quality"){
            steps{
                script{
                    def scannerHome = tool 'SonarScanner 4.0';
                    withSonarQubeEnv('My SonarQube Server') { 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
