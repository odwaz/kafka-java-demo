FROM openjdk:8-jdk-alpine
COPY target/kafka-java-demo-1.0-SNAPSHOT.jar kafka-java-demo.jar
ENTRYPOINT ["java","-jar","/kafka-java-demo.jar"]
