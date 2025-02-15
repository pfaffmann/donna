# Use an official Node.js runtime as the base image
FROM node:22-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) first to leverage Docker caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Compile TypeScript to JavaScript
RUN npm run build

FROM node:22-alpine 

ARG DONNA_PDF_PATH
ENV DONNA_PDF_PATH=${DONNA_PDF_PATH}

RUN mkdir -p $DONNA_PDF_PATH

WORKDIR /app

COPY --from=build /app/package*.json ./
RUN npm install --omit=dev
COPY --from=build /app/dist ./dist

# Command to start the application
CMD ["node", "dist/index.js"]