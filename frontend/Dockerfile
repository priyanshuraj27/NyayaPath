FROM ubuntu:latest as builder

RUN apt-get update && apt-get install -y curl git unzip xz-utils

# Install Flutter
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

# Build web version
RUN flutter build web --release

# Production stage
FROM nginx:stable-alpine

# Copy the build output
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]