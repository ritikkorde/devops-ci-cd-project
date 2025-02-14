# Use an official Node.js image as the base
FROM node:18-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire project and build the React app
COPY . .
RUN npm run build

# Use an Nginx image to serve the React app
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

