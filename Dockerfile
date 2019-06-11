FROM golang:1.12.5-alpine3.9

ENV GO111MODULE=on

ADD https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /app

COPY . .

RUN apk add --no-cache git

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build


CMD ["dumb-init", "/app/hello-kube"]