pipeline {
    agent any 
    environment {
	 dockerhub_vnd_cred=credentials('Dockerhub-cred')
	 //https://medium.com/codex/deploy-docker-image-to-kubernetes-cluster-using-jenkins-8182cc0a8de7
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
	      sh 'docker build -t vinod501/app .'
	      sh 'mvn clean install'
	      echo 'checking all versions'
	      sh 'mvn -v'
	      sh 'docker -v'
	      sh 'java -version'
	      sh 'jenkins --version'
	      
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
       stage('Pull image from Dockerhub and Deploy and run image') { 
          steps {
	         echo 'deploy'
                 sh 'docker pull vinod501/app:latest'
		 sh 'docker container run -d vinod501/app:latest'   
				sshagent(['k8s-jenkins'])
				{
					sh 'scp -r -o StrictHostKeyChecking=no node-deployment.yaml kubernetes@34.123.212.37:/path'
					
					script{
						try{
							sh 'ssh kubernetes@34.123.212.37 kubectl apply -f /path/node-deployment.yaml --kubeconfig=/path/kube.yaml'

							}catch(error)
							{

							}
					}
				}
			}
            }
       }
       
       //stage('cleanup local images') { 
         //steps {
	      //echo 'Deleting all local images'
            //sh 'docker image prune -af'
            //https://github.com/fatihtepe/Jenkins-Pipeline-to-Push-Docker-Images-to-ECR/blob/main/Jenkinsfile
            //sh 'docker logout'
		//}
	//}
//}

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
