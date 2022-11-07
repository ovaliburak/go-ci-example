pipeline{
    agent any
    stages{
        stage("sonar quality"){
            steps{
                script{
                    def scannerHome = tool 'sonarqube-scanner';
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh "pwd"
                        sh "go test -v -coverprofile=coverage.out ./app/test/..." 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
