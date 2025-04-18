FROM ubuntu:latest as builder

# Install dependencies
RUN apt-get update && apt-get install -y curl git unzip xz-utils

# Clone Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Enable web support
RUN flutter config --enable-web

WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./
# Get Flutter packages
RUN flutter pub get

# Copy the whole Flutter project
COPY . .

# Create a dummy .env file since it's required in the assets
RUN echo "# Dummy environment file for Docker build" > .env

# Build web version
RUN flutter build web --release

# Production stage
FROM nginx:stable-alpine

# Copy the build output
COPY --from=builder /app/build/web /usr/share/nginx/html

# Create a simple nginx config for SPA routing
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]