# # 🧱 Stage 1: Build the JAR with Maven and JDK 24
# FROM maven:3.9.6-eclipse-temurin-24 AS build
# WORKDIR /app
#
# # Copy pom.xml and source code
# COPY pom.xml .
# COPY src ./src
#
# # Build the project and skip tests for faster builds
# RUN mvn clean package -DskipTests
#
# # 🚀 Stage 2: Run the JAR with JRE 24
# FROM eclipse-temurin:24-jre
# WORKDIR /app
#
# # Copy the JAR from build stage
# COPY --from=build /app/target/*.jar app.jar
#
# # Expose the default Spring Boot port
# EXPOSE 8080
#
# # Run the application
# ENTRYPOINT ["java", "-jar", "app.jar"]
#this compiles the whole project into a container "build"
From maven:3.9.4-eclipse-temurin-21-alpine AS build
COPY . .
RUN mvn clean package -Dskiptests


#this here is used to store that container into are root directory and run the build
FROM openjdk:21-jdk-slim
COPY --from=build /target/FullstackBackendApplication-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]