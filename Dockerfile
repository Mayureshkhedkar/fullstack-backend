# FROM docker pull maven:3.9.11-eclipse-temurin-17 AS build
# COPY . .
# RUN mvn clean package -DskipTests
#
# FROM eclipse-temurin:17-alpine
# Stage 1: build the jar using Maven
# FROM maven:3.9.0-eclipse-temurin-17 AS build
# WORKDIR /app
#
# # copy pom and source, then build
# COPY pom.xml .
# COPY src ./src
# RUN mvn clean package -DskipTests
#
# # Stage 2: run the jar
# FROM eclipse-temurin:17-jre
# WORKDIR /app
#
# # copy the built jar (assumes one jar in target)
# COPY --from=build /app/target/*.jar app.jar
#
# EXPOSE 8080
#
# ENTRYPOINT ["java", "-jar", "app.jar"]
# Stage 1: Build
# FROM maven:3.9.8-eclipse-temurin-21 as builder
# WORKDIR /app
#
# COPY pom.xml .
# COPY src ./src
#
# RUN mvn clean package -DskipTests
#
# # Stage 2: Run
# FROM openjdk:17-jdk-slim
#
# WORKDIR /app
#
# COPY --from=builder /app/target/*.jar app.jar
#
# EXPOSE 8080
#
# ENTRYPOINT ["java", "-jar", "app.jar"]
# Stage 1: Build
## Stage 1: Build the JAR using Maven and JDK 22
 FROM maven:3.9.6-eclipse-temurin-22 AS build
 WORKDIR /app

 # Copy pom and source, then build
 COPY pom.xml .
 COPY src ./src
 RUN mvn clean package -DskipTests

 # Stage 2: Run the JAR using JRE 22
 FROM eclipse-temurin:22-jre
 WORKDIR /app

 # Copy the built JAR (assumes one jar in target)
 COPY --from=build /app/target/*.jar app.jar

 EXPOSE 8080

 ENTRYPOINT ["java", "-jar", "app.jar"]