FROM openjdk:8

ADD /home/ubuntu/jenkins/workspace/test2/target/javaexpress-springboot-docker*.jar javaexpress-springboot-docker.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","javaexpress-springboot-docker.jar"]
