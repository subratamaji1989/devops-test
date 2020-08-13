pipeline {
  agent master

  options {
    timestamps()
  }

  environment {
    //Use Pipeline Utility Steps plugin to read information from pom.xml into env variables
    IMAGE = readMavenPom().getArtifactId()
    VERSION = readMavenPom().getVersion()
  }

  tools {
          maven 'Maven 3.3.9'
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
              post {
                  success {
                      junit 'target/surefire-reports/**/*.xml'
                  }
              }
          }
      }

    stage('Code Quality Check via SonarQube') {
    agent SonarQube
      steps {
        script {
		  def scannerHOME = tool'SonarScanner';
			withSonarQubeEnv("scannerHOME") {
			    sh "${tool("scannerHOME")}/bin/sonar-scanner \
			    -Dsonar.projectKey=java.sample.myapp \
			    -Dsonar.projectName='JavaSample' \
			    -Dsonar.projectVersion=1.0.0 \
			    -Dsonar.sources=. \
			    -Dsonar.language=java"
			}
		}
      }
    }

	stage('Image Build and Publish') {
      steps {
        sh """
          docker build -t ${IMAGE} .
          docker tag ${IMAGE} ${IMAGE}:${VERSION}
          docker push ${IMAGE}:${VERSION}
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