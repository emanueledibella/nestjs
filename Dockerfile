FROM node:alpine

WORKDIR /app

COPY . /app

RUN npm ci

RUN npm run build

ENTRYPOINT docker/entrypoint.sh