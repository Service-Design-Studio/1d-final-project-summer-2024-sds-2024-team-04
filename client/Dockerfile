# Use the official lightweight Node.js image.
# https://hub.docker.com/_/node
FROM node:22-slim

# Create and change to the app directory.
WORKDIR /app

# Copy application dependency manifests to the container image.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install dependencies. 
# --omit=dev removes devDependencies
# --only=production remove both devDependecies and optionalDependencies
RUN npm install --only=production 

# Copy local code to the container image.
COPY . ./

# Build static files
# TODO: Adjust accordingly, this script is for Vite which puts the compiled files in dist
RUN npm run build

# Run the service on container startup.
# TODO: Assumes vite, so the built files are in dist, change accordingly
CMD [ "npx", "serve", "-s", "build"]