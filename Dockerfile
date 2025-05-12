# Use an official Maven image with Java 8 to build the application
FROM maven:3.9.4-eclipse-temurin-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven configuration and source code
COPY pom.xml ./

COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# Use an official Java 8 runtime image to run the application
FROM eclipse-temurin:8-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.war app.war

# Expose the default Spring Boot port
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
    CMD curl -f http://localhost:8000/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.war"]
