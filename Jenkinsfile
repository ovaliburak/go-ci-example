pipeline{
    agent any

    tools {
        go 'go'
    }

    environment {
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
    }

    stages{

        stage("sonar quality"){
            
            steps{
                dir("./test") {
                    sh "go test -v -coverprofile=coverage.out ./..."
                }
            }

            steps{
                def scannerHome = tool 'sonarqube-scanner';
                withSonarQubeEnv(credentialsId: 'sonar-token') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage("Quality Gate"){
            
            steps{
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                } 
            }
        }
    }
}
