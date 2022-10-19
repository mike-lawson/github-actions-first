FROM node:16-alpine as builder

WORKDIR /usr/src/app
COPY package*.json ./

RUN yarn install --pure-lockfile --non-interactive --quiet
COPY tsconfig*.json ./
COPY src src

RUN yarn build

FROM node:16-alpine
WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn --production --quiet
COPY --from=builder /usr/src/app/dist ./dist

CMD ["yarn", "start"]