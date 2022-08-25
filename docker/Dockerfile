ARG PORT=5000

# Base image stage
FROM node:16-alpine as node

RUN apk --no-cache -U upgrade
RUN apk update
RUN apk update && apk add build-base autoconf automake libtool pkgconfig nasm
RUN apk add --no-cache curl
RUN npm install npm@latest -g

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Builder stage
FROM node AS builder
ENV PATH /code/node_modules/.bin:$PATH

WORKDIR /code
COPY package*.json ./
RUN npm install --platform=linux --libc=musl --arch=x64 sharp --ignore-scripts --force && npm rebuild --platform=linux --libc=musl --arch=x64 sharp && npm cache clean --force

WORKDIR /code/app
COPY . ./

RUN npm run build

# deploy stage
FROM nginx:alpine as deploy

LABEL maintainer "Jose Luis Camargo Calizaya"

ARG PORT
ENV PORT $PORT

EXPOSE $PORT

RUN apk add --no-cache curl

COPY --from=builder /code/app/public /usr/share/nginx/html
COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.template

HEALTHCHECK --interval=30s --timeout=60s --start-period=10s --retries=3 CMD curl --fail localhost:$PORT || exit 1

CMD ["/bin/sh" , "-c" , "envsubst \"`env | awk -F = '{printf \" \\\\$%s\", $1}'`\" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]