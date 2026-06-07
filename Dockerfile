
# Stage-1: Build the react application

# Base image
FROM node:20-alpine as build

# Working directory
WORKDIR /app

# Copy the dependencies and the codes
COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Stage-2: We serve the react application that build in Stage 1
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]