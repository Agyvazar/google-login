#
# Build stage
#
#FROM maven:3.6.0-jdk-11-slim AS build
#COPY src /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
#FROM openjdk:11-jre-slim
#COPY --from=build /home/app/target/*.jar /usr/local/lib/app.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]


FROM openjdk:17-jdk-slim AS build

COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN ./mvnw dependency:resolve

COPY src src
RUN ./mvnw package
#
#FROM openjdk:17-jdk-slim
#WORKDIR demo
#COPY --from=build target/*.jar demo.jar
#ENTRYPOINT ["java", "-jar", "demo.jar"]
#



FROM openjdk:17-jdk-alpine
COPY target/google-login.jar google-login.jar
ENTRYPOINT ["java","-jar","/google-login.jar"]