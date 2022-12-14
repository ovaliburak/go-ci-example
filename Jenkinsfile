pipeline{
    agent any
    tools {
        go 'go'
    }
    environment {
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        registry = "docker.io/burakovali/go-app"
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
        stage("Building Image"){
            steps{
                script{
                    dockerImage = docker.build("burakovali/go-app")
                }
            }
        }
        stage("Deploy Image"){
            steps{
                script{
                    docker.withRegistry("https://registry.hub.docker.com", 'dockerlogin'){
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage("Indentifying misconfigs with Datree in Helm Charts"){
            steps{
                script{
                    dir('k8s/') {
                        withEnv(['DATREE_TOKEN=8c589423-b1bd-4686-aa6a-1e2779d7f268']) {
                            sh "helm datree test helm/go-app/"
                        }       
                    }
                }
            }
        }
        stage("Take Release App"){
            steps{
                script{
                    dir('k8s/releases/') {
                        sh '''
                            helmversion=$(helm show chart ../helm/go-app/ | grep version | cut -d: -f 2 | tr -d ' ')
                            tar -czvf go-app-${helmversion}.tgz ../helm/go-app/
                            // helm repo index . --url https://ovaliburak.github.io/go-gcp-devops-project/
                        '''
                    }
                }
            }
        }
        stage("Push Helm Chart to Repo"){
            steps{
                dir('k8s/releases/') {
                    // git branch: 'gh-pages',
                    // credentialsId: 'git-cred',
                    // url: 'git@github.com:ovaliburak/go-gcp-devops-project.git'
                    // sh "git add . && git commit -m "new releases added"
                    pwd
                }       
            }
        }
    }
}
