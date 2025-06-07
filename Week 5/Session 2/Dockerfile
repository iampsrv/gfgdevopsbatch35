# Use a lightweight Linux base image
FROM alpine:latest

# Create a working directory
WORKDIR /app

# Copy the script into the container
COPY hello_world.sh .

# Make the script executable
RUN chmod +x hello_world.sh

# Run the script when the container starts
CMD ["./hello_world.sh"]
