pipeline {
    agent any 
    environment {
		 dockerhub_vnd_cred=credentials('Dockerhub-cred') //Manage jenkins ->Manage credentials ->System ->Global credentials ->add credential ->username and pwd
	         USE_GKE_GCLOUD_AUTH_PLUGIN = 'True'              //vinod501(dockerhub username)   //dockerhub pwd: **********   
		 //PROJECT_ID = 'ferrous-depth-373006'            //https://www.youtube.com/watch?v=8YyamgWdvFg	
		 //CLUSTER_NAME = 'autopilot-cluster-1'           //https://medium.com/codex/deploy-docker-image-to-kubernetes-cluster-using-jenkins-8182cc0a8de7
		 //LOCATION = 'us-central1'
		 //CREDENTIALS_ID = 'kubernetes'        
	}
    tools {
        maven 'mvn3'                                             //tools added in global tool configuration mention here otherwise it will not know where to pick maven
        }


    stages {  
        stage ('FETCH THE CODE'){
          steps {
             git 'https://github.com/chvinodgcp5010/https-github.com-Java-Techie-jt-docker-jenkins-integration-sample.git'
                    //Here if you donot have any idea how to add git to pipeline -> simply go to "pipeline job" -> Click on "pipeline sysntx" (bottom) and add git and url and generate script
           }
        }
	    
        stage('BUILD AND PACKAGING TO DOCKER IMAGE') { 
          steps {
	      echo 'build'
	      sh 'mvn clean install'
	      sh 'docker build -t vinod501/app .'
            }
        }
	    
        stage('LOGIN TO DOCKERHUB AND PUSH IMAGE') {
	      steps {
		  sh 'echo $dockerhub_vnd_cred_PSW | docker login -u $dockerhub_vnd_cred_USR --password-stdin'
		  sh 'docker push vinod501/app:latest'
		}
	     }
	    
       stage('PULL IMAGE FROM DOCKERHUB AND RUN DOCKER IMAGE') { 
          steps {
	         echo 'deploy'
                 sh 'docker pull vinod501/app:latest'
		 sh 'docker container run -d vinod501/app:latest'   
            }
       }  
	    
       stage('CLEANUP LOCAL IMAGES') { 
         steps {
	      echo 'Deleting all local images'
              sh 'docker image prune -af'
              //https://github.com/fatihtepe/Jenkins-Pipeline-to-Push-Docker-Images-to-ECR/blob/main/Jenkinsfile
              sh 'docker logout'
		}
	}
	    
       stage('DEPLOY APPLICATION to GKECLUSTER') {
           steps{
                sh 'export USE_GKE_GCLOUD_AUTH_PLUGIN=True'
                sh 'gcloud container clusters get-credentials iqoo-cluster --zone us-central1-c --project ferrous-depth-373006'
                sh 'kubectl delete -f kubernetes/deployment/deployment.yaml || echo \"deployment not available\"'
                sh 'kubectl create -f kubernetes/deployment/deployment.yaml'
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
