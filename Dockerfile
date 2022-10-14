FROM node:16-alpine as build-stage

WORKDIR /app

COPY ./vite-project .
RUN yarn install
RUN yarn build

FROM nginx:1.18.0 as deploy-stage

WORKDIR /usr/share/nginx/html

RUN rm -rf *
COPY --from=build-stage /app/dist .
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off"]