#FROM openjdk:8-jdk-alpine
FROM amazoncorretto:17.0.8-alpine3.18
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]