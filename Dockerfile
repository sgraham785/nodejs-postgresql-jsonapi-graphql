FROM node:6.9.5

RUN mkdir -p /app/logs
ADD .foreverignore /app
COPY target /app
COPY dist /app
WORKDIR /app
CMD npm start

