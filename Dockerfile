# Use the official Flutter image as a parent image
FROM cirrusci/flutter:latest

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Use nginx to serve the app
FROM nginx:alpine

# Copy the nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built app to the nginx serve directory
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
