# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER subrata
COPY ./webapp.war /usr/local/tomcat/webapps

