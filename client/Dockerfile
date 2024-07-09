# Dockerfile for React Frontend
FROM node:14

# Set working directory
WORKDIR /app

# Install dependencies
COPY client/package.json client/package-lock.json ./
RUN npm install

# Copy the project files
COPY client/ ./

# Build the app
RUN npm run build

# Start the app
CMD ["npm", "start"]

EXPOSE 3000
