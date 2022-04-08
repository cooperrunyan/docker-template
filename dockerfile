# Base
FROM node:16.14.2-alpine as base
WORKDIR /home/node/app

COPY package* .
RUN npm i

COPY . .

# Production Build
FROM base as production

ENV NODE_PATH=./bin
RUN npx tsc -p .
