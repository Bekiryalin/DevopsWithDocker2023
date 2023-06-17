FROM docker:latest

WORKDIR /usr/src/app

RUN apk add --no-cache git

COPY builder.sh .

ENTRYPOINT ["/bin/sh", "./builder.sh"]
