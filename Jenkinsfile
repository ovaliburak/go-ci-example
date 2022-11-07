pipeline{
    agent any
    tools {
        go 'go'
        docker 'docker'
    }
    environment {
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        registry = "burakovali/go-app"
        registryCredential = credentials("dockerlogin")
    }
    stages{
        stage("Go Test"){
            
            steps{
                dir("./test") {
                    sh "go test -v -coverprofile=coverage.out ./..."
                }
            }
        }
        stage("SonarQube Analysis"){
            steps{
                script{
                    def scannerHome = tool 'sonarqube-scanner';
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
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
        stage("Initialize Docker"){
            env.PATH = "${docker}/bin:${env.PATH}"
        }
        stage("Building Image"){
            steps{
                sh dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
        }
        stage("Deploy Image"){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        dockerImage.push()
                    }
                }
            }
        }
    }
 
    
}
