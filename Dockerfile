# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER subrata
COPY ./webapp/target/webapp.war /usr/local/tomcat/webapps

