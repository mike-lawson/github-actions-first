FROM node:16-alpine as builder

COPY package*.json ./

RUN yarn install --pure-lockfile --non-interactive --quiet
COPY tsconfig*.json ./
COPY src src

RUN yarn build

FROM node:16-alpine

COPY package*.json ./
RUN yarn --production --quiet
COPY --from=builder /dist ./dist

CMD ["yarn", "start"]