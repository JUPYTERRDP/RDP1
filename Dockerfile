# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip -O ngrok.zip

# Extract ngrok
RUN unzip ngrok.zip && \
    rm ngrok.zip

# Set ngrok auth token environment variable
ENV NGROK_AUTH_TOKEN=$NGROK_AUTH_TOKEN

# Expose port for ngrok tunnel (if needed)
# EXPOSE 3389

# Set ngrok auth token and start ngrok tunnel as the entrypoint
ENTRYPOINT ["./ngrok", "authtoken", "$NGROK_AUTH_TOKEN", "&&", "./ngrok", "tcp", "3389"]
