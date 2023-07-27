FROM openjdk:8

ADD target/javaexpress-springboot-docker.jar /app/javaexpress-springboot-docker.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","javaexpress-springboot-docker.jar"]
