FROM maven:3.6-jdk-8-alpine as build
COPY . .
RUN mvn clean package

FROM openjdk:8-jre
MAINTAINER "andy.knapp.ak@gmail.com"
COPY --from=build ./target/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar /opt/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar"]
