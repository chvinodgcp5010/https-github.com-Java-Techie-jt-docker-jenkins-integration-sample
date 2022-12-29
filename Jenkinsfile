pipeline {
    agent any 
    environment {
		   dockerhub_vnd_cred=credentials('Dockerhub-cred')
		   //https://github.com/chvinodgcp5010/jenkinsfile-tutorial/blob/master/part02-pipeline-variables/env2.jenkins
		   //https://www.youtube.com/watch?v=8YyamgWdvFg
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
		 sh 'echo $dockerhub_vnd_cred_PSW | docker login -u $dockerhub_vnd_cred_USR --password-stdin'
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
               // 
           }
       }
       
       stage('cleanup local images') { 
         steps {
	      echo 'Deleting all local images'
            sh 'docker image prune -af'
            //https://github.com/fatihtepe/Jenkins-Pipeline-to-Push-Docker-Images-to-ECR/blob/main/Jenkinsfile
            sh 'docker logout'
		}
	}
}
    post {
        //https://github.com/chvinodgcp5010/jenkinsfile-tutorial/blob/master/part04-post-actions/post1.jenkins
        always {
            echo "This block always runs."
        }
        aborted {
            echo "This block runs when the build process is aborted."
        }
        failure {
            echo "This block runs when the build is failed."
        }
        success {
            echo "This block runs when the build is succeeded."
        }
    }
}
