pipeline {
  agent {
    kubernetes {
      label 'jenkins-slave'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: maven
    image: maven:3.3.9-jdk-8-alpine
    command:
      - cat
    tty: true
    volumeMounts:
      - mountPath: "/root/.m2/repository"
        name: maven-repo
      - mountPath: "/home/jenkins/.m2"
        name: maven-settings-xml
    env:
      - name: NEXUS_USERNAME
        valueFrom:
          secretKeyRef:
            name: nexus-admin-credentials
            key: username
      - name: NEXUS_PASSWORD
        valueFrom:
          secretKeyRef:
            name: nexus-admin-credentials
            key: password
  volumes:
  - name: maven-repo
    persistentVolumeClaim:
      claimName: maven-repo
  - configMap:
      name: maven-settings-xml
      defaultMode: 420
    name: maven-settings-xml
"""
    }
  }
  stages {
    stage('Build a Maven project') {
      steps {
        container('maven') {
            sh 'mvn clean package -s /home/jenkins/.m2/settings.xml'
        }
      }
    }


    stage('Push artifacts to Nexus') {
      steps {
        container('maven') {
            sh "mvn deploy:deploy-file \
                -DgroupId=com.boraji.tutorial.springboot \
                -DartifactId=spring-boot-hello-world-example \
                -Dversion=0.0.1 \
                -Dpackaging=jar \
                -Dfile=target/spring-boot-hello-world.jar \
                -DgeneratePom=false \
                -DrepositoryId=nexus-releases \
                -Durl=http://nexus-sonatype-nexus.nexus:8080/repository/maven-releases/ \
                -s /home/jenkins/.m2/settings.xml"
        }
      }
    }
  }
}
