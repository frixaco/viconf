FROM node:14-alpine as builder

ARG SOCKET_PORT=5000
ENV REACT_APP_SOCKET_PORT=${SOCKET_PORT}

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev rust cargo
RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt

COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

## Remove default nginx index page
# RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
