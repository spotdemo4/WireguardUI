FROM node:19 AS node

# Define environment variables
ARG ORIGIN
ENV ORIGIN $ORIGIN

# Install dependencies
WORKDIR /app
COPY ./package.json .
COPY ./package-lock.json .
COPY ./svelte.config.js .
RUN npm install

# Move everything to container
COPY . .

# Generate prisma
RUN npx prisma generate

# Build for production
RUN npm run build

# Launch app
CMD ["node", "build"]
EXPOSE 3000