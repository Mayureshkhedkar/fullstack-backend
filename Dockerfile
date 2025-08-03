 FROM maven:3.9.4-eclipse-temurin-21-alpine AS build
 WORKDIR /FullstackBackendApplication
 COPY pom.xml .
 COPY src ./src

 RUN mvn clean package -DskipTests

 FROM openjdk:21-jdk-slim
 WORKDIR /FullstackBackendApplication

 COPY --from=build /target/*.jar app.jar
 EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]


##this compiles the whole project into a container "build"
#From maven:3.9.4-eclipse-temurin-21-alpine AS build
#COPY . .
#RUN mvn clean package -Dskiptests
#
#
##this here is used to store that container into are root directory and run the build
#FROM openjdk:21-jdk-slim
#COPY --from=build /target/FullstackBackendApplication-0.0.1-SNAPSHOT.jar demo.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","demo.jar"]