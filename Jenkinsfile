pipeline{
    agent any
    stages{
        stage("sonar quality"){
            agent {
                docker {
                    image 'sfydli/golang-sonar-scanner'
                }
            }
            steps{
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh 'go test -v -coverprofile=coverage.out ./...'
                    }
                }
            }
        }
    }
}
