# Use the official Ubuntu image
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

# Set ngrok auth token
ENV NGROK_AUTH_TOKEN=$NGROK_AUTH_TOKEN

# Expose port and create tunnel
EXPOSE 3389

# Use ENTRYPOINT to set ngrok auth token and start ngrok tunnel
ENTRYPOINT ["./ngrok", "authtoken", "$NGROK_AUTH_TOKEN", "&&", "./ngrok", "tcp", "3389"]
