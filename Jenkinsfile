pipeline{
    agent any
    stages{
        stage("sonar quality"){
            steps{
                dir("./test") {
                    sh "pwd"
                }
                script{
                    def scannerHome = tool 'sonarqube-scanner';
                    withSonarQubeEnv(credentialsId: 'sonar-token') {

                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
