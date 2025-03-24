FROM node:16
WORKDIR /app
COPY app/package.json .
RUN npm install
COPY app .
CMD ["node", "server.js"]
