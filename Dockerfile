FROM node:alpine as builder

WORKDIR /app/src/

RUN apk add --no-cache --virtual .gyp python make g++

COPY ./package*.json ./

RUN npm install


FROM node:alpine as app

WORKDIR /app/src/

COPY --from=builder /app/src/node_modules/ ./node_modules/
COPY . ./

RUN npm run build

EXPOSE 3000

COPY .env ./

ENTRYPOINT [ "npm", "start" ]