FROM node:16-alpine as builder

COPY package*.json ./

RUN yarn install --pure-lockfile --non-interactive --quiet
COPY tsconfig*.json ./
COPY src src

RUN yarn build

FROM node:16-alpine as cloner
RUN git clone https://github.com/mike-lawson/github-actions-second

FROM node:16-alpine

COPY package*.json ./
RUN yarn --production --quiet
COPY --from=builder /dist ./dist
COPY --from=cloner /github-actions-second ./dist/github-actions-second

CMD ["yarn", "start"]