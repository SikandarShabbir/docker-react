FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install -g npm@7.18.1

COPY . .

RUN npm run build

RUN npm i react-scripts

#RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
 #   && ln -s /usr/local/bin/docker-entrypoint.sh /

FROM nginx

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
