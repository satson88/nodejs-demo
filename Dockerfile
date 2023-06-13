# Specify the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose a port (optional, if your application needs to listen on a specific port)
EXPOSE 3000

# Define the command to start the application
CMD ["npm", "start"]