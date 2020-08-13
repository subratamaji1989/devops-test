pipeline {
  agent {
      node {
        label 'master'
      }
    }

  options {
    timestamps()
  }

  environment {
    //Use Pipeline Utility Steps plugin to read information from pom.xml into env variables
    ACC = 'maji1989'
    IMAGE = 'javasample'
    VERSION = '1.0'
  }

  tools {
          maven 'M2_HOME'
          jdk 'jdk8'
  }
      stages {
          stage ('Initialize') {
              steps {
                  sh '''
                      echo "PATH = ${PATH}"
                      echo "M2_HOME = ${M2_HOME}"
                  '''
              }
          }

          stage ('Build') {
              steps {
                  sh 'mvn -Dmaven.test.failure.ignore=true clean install'
              }
          }
/*
        stage('Code Quality Check via SonarQube') {
            agent {
                node {
                  label 'SonarQube'
                }
              }
              steps {
                git url: 'https://github.com/subratamaji1989/devops-test.git'
                script {
                  def scannerHOME = tool'SonarScanner';
                    withSonarQubeEnv("SonarQube") {
                        sh "${tool("SonarScanner")}/bin/sonar-scanner \
                        -Dsonar.projectKey=java.sample.myapp \
                        -Dsonar.projectName='JavaSample' \
                        -Dsonar.projectVersion=1.0.0 \
                        -Dsonar.sources=. \
                        -Dsonar.language=java"
                    }
                }
              }
        }
*/
        stage('Image Build and Publish') {
          steps {
            sh """
              docker build -t ${IMAGE} .
              docker tag ${IMAGE} ${ACC}/${IMAGE}:${VERSION}
              docker push ${ACC}/${IMAGE}:${VERSION}
            """
          }
        }
    }

  post {
    success {
        echo "All stages got success"
    }
  }
}