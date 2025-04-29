FROM node:14

# Install simple HTTP server
RUN npm install -g http-server

# Set working directory
WORKDIR /app

# Copy everything into the container
COPY . .

# Expose port 3000
EXPOSE 3000

# Serve static files from current directory
CMD ["http-server", "-p", "3000"]
