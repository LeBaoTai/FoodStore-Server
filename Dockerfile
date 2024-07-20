# Use the official OpenJDK image for JDK 22 as a parent image
FROM openjdk:22-jdk-slim

# Set the working directory in the container
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN chmod +x ./mvnw
RUN ./mvnw dependency:resolve

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]