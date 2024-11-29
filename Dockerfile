FROM fame-registry-vpc.cn-shanghai.cr.aliyuncs.com/base/node:12.16.0 AS builder
WORKDIR /app
ARG TYPE_ENV
ENV TYPE_ENV $TYPE_ENV
ENV SASS_BINARY_SITE https://npmmirror.com/mirrors/node-sass
COPY package.json .
RUN npm install --registry=https://registry.npmmirror.com
COPY . .
RUN npm run-script build:${TYPE_ENV}
FROM fame-registry-vpc.cn-shanghai.cr.aliyuncs.com/base/nginx:alpine
COPY --from=builder /app/dist /build
