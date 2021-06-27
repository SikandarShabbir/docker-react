FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
 #   && ln -s /usr/local/bin/docker-entrypoint.sh /

#FROM nginx
FROM nginx:alpine

COPY toborFront.conf /etc/nginx/conf.d/
#EXPOSE 8080

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
