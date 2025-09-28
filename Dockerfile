## Multi-stage Dockerfile to build and serve CompreFace UI

# --- Build stage ---
FROM node:14 AS build
WORKDIR /usr/src/app
ARG APP_DIR=ui

# Install dependencies first (better layer caching)
COPY ${APP_DIR}/package.json ./
RUN npm install

# Copy source and build
COPY ${APP_DIR}/ .
RUN npm run build:prod

# --- Runtime stage ---
FROM nginx:1.21.1

# Copy built assets
COPY --from=build /usr/src/app/dist/compreface /usr/share/nginx/html

# Use project Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/nginx/ /etc/nginx/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


