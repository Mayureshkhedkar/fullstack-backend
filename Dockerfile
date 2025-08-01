FROM docker pull maven:3.9.11-eclipse-temurin-17 AS build
COPY . .
RUN mvn clean package -DskipTests