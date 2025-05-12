#!/bin/bash

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "Maven is not installed. Installing Maven..."

    # Install Maven on Ubuntu/Debian-based systems
    if [ -f /etc/debian_version ]; then
        sudo apt update
        sudo apt install -y maven
    # Install Maven on CentOS/RHEL-based systems
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y maven
    # Install Maven on macOS (using Homebrew)
    elif command -v brew &> /dev/null; then
        brew install maven
    else
        echo "Unsupported OS. Please install Maven manually."
        exit 1
    fi

    # Verify Maven installation
    if ! command -v mvn &> /dev/null; then
        echo "Failed to install Maven. Exiting..."
        exit 1
    fi
    echo "Maven installation successful."
else
    echo "Maven is already installed."
fi

# Set the path to your project directory (optional, adjust as needed)
PROJECT_DIR="/home/shorouk/DevOps/DevOps_MVN_Server"

# Navigate to your project directory
cd "$PROJECT_DIR" || exit

# Clean and build the Spring Boot application using Maven
echo "Building the Spring Boot application..."
mvn clean install -DskipTests

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Build successful. Starting the Spring Boot application..."

    # Run the Spring Boot application
    mvn spring-boot:run
else
    echo "Build failed. Please check the errors above."
    exit 1
fi
