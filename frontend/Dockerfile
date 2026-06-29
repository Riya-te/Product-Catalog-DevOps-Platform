# Multi-stage build
FROM node:18-alpine AS builder

WORKDIR /app

# Accept build arguments
# Default to empty strings for nginx reverse proxy (relative URLs via nginx)
# Can be overridden at build time: --build-arg REACT_APP_PRODUCT_API=http://product-service:5000
#ARG REACT_APP_PRODUCT_SERVICE_URL=http://localhost:5000
#ARG REACT_APP_RATINGS_SERVICE_URL=http://localhost:5001
ARG REACT_APP_PRODUCT_API=
ARG REACT_APP_RATINGS_API=

# Set environment variables for build
# Map ARG names to ENV names that React app expects
ENV REACT_APP_PRODUCT_SERVICE_URL=$REACT_APP_PRODUCT_API
ENV REACT_APP_RATINGS_SERVICE_URL=$REACT_APP_RATINGS_API

# Copy package files
COPY package*.json ./

# Install dependencies (use install instead of ci since package-lock.json may not exist)
RUN npm install

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built files from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

