//Pipeline

pipeline {
    agent any 
    environment {
		   DOCKERHUB_CREDENTIALS=credentials('Dockerhub-cred')
	  }
    tools {
        maven 'mvn3'
        // tools added in global tool configuration mention here otherwise it will not know where to pick maven
         }
    stages {  
        stage ('fetch the code'){
          steps {
             git 'https://github.com/chvinodgcp5010/https-github.com-Java-Techie-jt-docker-jenkins-integration-sample.git'
             //Here if you donot have any idea how to add git to pipeline -> simply go to "pipeline job" -> Click on "pipeline sysntx" (bottom) and add git and url and generate script
           }
        }
        stage('Build and packaging') { 
          steps {
	           echo 'build'
	           sh 'mvn clean install'
	           sh 'docker build -t vinod501/app .'
                // 
            }
        }
        stage('Test') { 
          steps {
	           echo 'test'
              // 
             }
         }
         stage('Login') {
	     steps {
		 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			 }
		   }
        stage('Push image to docker registry') {
			    steps {
				    sh 'docker push vinod501/app:latest'
			     }
		   }
       stage('Deploy') { 
           steps {
	         echo 'deploy'
                 sh 'docker pull vinod501/app:latest'
		 //sh 'docker container run -d -p 8080:8081 vinod501/app:latest'
		 sh 'docker container run -d vinod501/app:latest'
           }
       }
    }
      post {
		always {
			sh 'docker logout'
		}
	}
 }
