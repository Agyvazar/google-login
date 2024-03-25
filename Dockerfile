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


FROM openjdk:17-jdk-alpine AS build

COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN ./mvnw dependency:resolve

COPY src src
RUN ./mvnw package



FROM openjdk:17-jdk-alpine
COPY --from=build target/google-login.jar google-login.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/google-login.jar"]