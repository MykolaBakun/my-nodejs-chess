FROM node:10-alpine

RUN mkdir /my-nodejs-chess
COPY . /my-nodejs-chess
WORKDIR /my-nodejs-chess

RUN npm install --ignore-scripts --no-optional
CMD node ./lib/server/seedDB.js
CMD node ./lib/server/index.js

EXPOSE 8081