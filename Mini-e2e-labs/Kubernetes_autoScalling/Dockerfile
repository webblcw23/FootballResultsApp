FROM node:16

WORKDIR /usr/src/app
COPY app/ .
RUN npm install

EXPOSE 3000
CMD ["node", "app.js"]
