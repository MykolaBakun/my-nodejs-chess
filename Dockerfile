FROM node:10-alpine

RUN mkdir /nodejs-app
COPY . /nodejs-app
WORKDIR /nodejs-app

ENV DB_URL="http://locolhost:8080"

CMD export DB_URL=$DB_URL

RUN npm install
CMD node ./lib/server/seedDB.js
CMD node ./lib/server/index.js

EXPOSE 8081