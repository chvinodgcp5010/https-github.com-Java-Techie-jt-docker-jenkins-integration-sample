FROM openjdk:8
EXPOSE 8080
ADD target/docker-jenkins-integration-sample.jar docker-jenkins-integration-sample.jar
ENTRYPOINT ["java","-jar","/docker-jenkins-integration-sample.jar"]


#Here maven build the code and save it on target folder and create "docker-jenkins-integration-sample.jar" based onb name given in "pom.xml" file
#you can copy "ADD target/docker-jenkins-integration-sample.jar docker-jenkins-integration-sample.jar" to  "docker continaer directory" 
#and to ["java","-jar","/docker-jenkins-integration-sample.jar"]
