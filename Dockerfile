# Use an official Node.js runtime as a base image
<<<<<<< HEAD
FROM node:node:20-alpine
=======
FROM node:20-slim
>>>>>>> 89aef32f56a472761ed4251b15e945b7b89756b3

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3003

# Command to run the application
CMD ["npm", "start"]
