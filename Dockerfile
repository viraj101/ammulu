FROM adoptopenjdk/openjdk11
RUN apt-get update -y && apt-get install -y apt-utils && apt-get install entr -y && apt-get install maven -y
RUN git clone git@github.com:digitalunit4ksb/KSB_PumpTest2_ReferenceImplementation.git && maven clean install
WORKDIR /app
COPY /target/referenceimplementation-0.0.1-SNAPSHOT.jar /app
EXPOSE 8080
CMD java -jar referenceimplementation-0.0.1-SNAPSHOT.jar ENRICH





sudo mount -t cifs -O username=boddpru //derlksb0091.EMEA.ksb.intern/D:/camos/ksb /mnt/win_share


#FROM openjdk:11-jre
FROM openjdk:11-jdk-alpine
#Base image 

FROM openjdk:11-jdk-slim

MAINTAINER prudviraj

#Run the command to update container

RUN apt-get update -y

# Creates directory in the container
WORKDIR /apps

#Copies content to container
ADD . /apps

#Expose port for container

EXPOSE 8090

#set the main command for container to start the application
CMD ["java", "-jar", "searcherservice.jar"]

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME


ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.32
WORKDIR /apps

#Copies content  the folder in the new container
ADD . /apps

ADD hydragui.war $CATALINA_HOME/webapps/

ADD searcherservice.jar /apps

#Expose port for container


EXPOSE 8090

#set the main command for container to start the application
CMD ["java", "-jar", "searcherservice.jar"]