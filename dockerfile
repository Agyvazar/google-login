FROM openjdk:17-jdk-alpine
COPY target/google-login.jar google-login.jar
ENTRYPOINT ["java","-jar","/google-login.jar"]