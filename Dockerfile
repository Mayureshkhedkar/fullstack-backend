#this compiles the whole project into a container "build"
From maven:3.9.4-eclipse-temurin-21-alpine AS build
COPY . .
RUN mvn clean package -Dskiptests


#this here is used to store that container into are root directory and run the build
FROM openjdk:21-jdk-slim
COPY --from=build /target/fullstack-backend-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
#ENTRYPOINT ["java","-cp","fullstack-backend-0.0.1-SNAPSHOT.jar","com.codedbymk.fullstack_backend.FullstackBackendApplication"]
ENTRYPOINT ["java","-jar","demo.jar"]