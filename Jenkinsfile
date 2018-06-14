/**
 * This pipeline will execute a simple Maven build
 */

podTemplate(label: 'maven', 
  containers: [
      containerTemplate(
          name: 'maven', 
          image: 'maven:3.3.9-jdk-8-alpine', 
          ttyEnabled: true, 
          command: 'cat',
          workingDir: '/home/jenkins',
          envVars: [
            secretEnvVar(key: 'NEXUS_USERNAME', secretName: 'nexus-admin-credentials', secretKey: 'username'),
            secretEnvVar(key: 'NEXUS_PASSWORD', secretName: 'nexus-admin-credentials', secretKey: 'password')
          ]
      )
  ], 
  volumes: [
      persistentVolumeClaim(mountPath: '/root/.m2/repository', claimName: 'maven-repo', readOnly: false),
      configMapVolume(mountPath: '/home/jenkins/.m2', configMapName: 'maven-settings-xml')
  ]) {

  node('maven') {
    stage('Build a Maven project') {
      git 'https://github.com/jenkinsci/kubernetes-plugin.git'
      container('maven') {
          sh 'mvn clean package -s /home/jenkins/.m2/settings.xml'
      }
    }

    stage('Push artifacts to Nexus') {
      git 'https://github.com/jenkinsci/kubernetes-plugin.git'
      container('maven') {
          sh "mvn deploy:deploy-file \
              -DgroupId=com.boraji.tutorial.springboot \
              -DartifactId=spring-boot-hello-world-example \
              -Dversion=0.0.1 \
              -Dpackaging=jar \
              -Dfile=target/kubernetes.jar \
              -DgeneratePom=false \
              -DrepositoryId=nexus-releases \
              -Durl=http://nexus-sonatype-nexus.nexus:8080/repository/maven-releases/ \
              -s /home/jenkins/.m2/settings.xml"
      }
    }
  }
}


