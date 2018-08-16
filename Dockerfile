FROM openjdk:8-jre
MAINTAINER "andy.knapp.ak@gmail.com"
COPY ./target/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar /opt/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/spring-boot-hello-world-example-0.0.1-SNAPSHOT.jar"]
