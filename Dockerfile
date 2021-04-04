FROM node:10-alpine

RUN mkdir /nodejs-app
COPY . /nodejs-app
WORKDIR /nodejs-app

ENV DB_URL="mongodb://mykola:mykpas@localhost:27017/chessMEAN?authSource=admin"

CMD export DB_URL=$DB_URL

RUN npm install
CMD node ./lib/server/seedDB.js
CMD node ./lib/server/index.js

EXPOSE 8081