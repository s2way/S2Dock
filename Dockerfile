FROM node:4

MAINTAINER Telo <joaotelo.nh@hotmail.com>

COPY . /src

EXPOSE 1234

WORKDIR /src
RUN npm install

CMD ["npm", "start"]
