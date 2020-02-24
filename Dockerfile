FROM node:10

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

ENV DB_HOST=mongod://localhost:27017/posts

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
