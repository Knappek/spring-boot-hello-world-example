FROM maven:3.3.9-jdk-8-alpine as build
MAINTAINER "andy.knapp.ak@gmail.com"
COPY . /app
RUN cd /app && mvn clean package

FROM openjdk:8-jre
MAINTAINER "andy.knapp.ak@gmail.com"
COPY --from=build /app/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar /app/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar"]
