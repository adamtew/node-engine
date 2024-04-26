FROM golang:1.20-alpine

WORKDIR /app
COPY ./node-bin /app/nodes
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
