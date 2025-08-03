# 🧱 Stage 1: Build the JAR with Maven and JDK 24
FROM maven:3.9.6-eclipse-temurin-24 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project and skip tests for faster builds
RUN mvn clean package -DskipTests

# 🚀 Stage 2: Run the JAR with JRE 24
FROM eclipse-temurin:24-jre
WORKDIR /app

# Copy the JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]