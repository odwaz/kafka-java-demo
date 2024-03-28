# Use a base image with necessary tools for fetching the Git repository
FROM alpine:latest AS builder

# Install Git
RUN apk --no-cache add git


# Install Maven
RUN apk update && \
    apk add --no-cache maven
# Clone the Git repository into a temporary directory
WORKDIR /tmp
RUN git clone https://github.com/odwaz/kafka-java-demo.git

# Switch to the cloned repository directory
WORKDIR /tmp/kafka-java-demo

# Install Maven


# Build your application or perform any necessary setup
RUN mvn package

# Now create the final image with just the built artifact
FROM openjdk:8-jdk-alpine

# Copy the built artifact from the builder stage into the final image
COPY --from=builder /tmp/kafka-java-demo/target/kafka-java-demo-1.0-SNAPSHOT.jar /app/kafka-java-demo.jar
COPY --from=builder /tmp/yourrepository/target/kafka-java-demo-1.0-SNAPSHOT.jar /app/kafka-java-demo.jar
# Define the entrypoint
ENTRYPOINT ["java", "-jar", "/app/kafka-java-demo.jar"]
