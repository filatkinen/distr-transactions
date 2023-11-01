FROM golang:1.21-alpine as Builder
WORKDIR /usr/src/app/

COPY . /usr/src/app/
COPY ./deployment/orderservice/orderservice.env /usr/src/app/orderservice.env

RUN go build -v -o ./bin/orderservice  ./cmd/orderservice

FROM debian:stable-slim
COPY --from=builder /usr/src/app/bin/orderservice /app/bin/orderservice
COPY --from=builder /usr/src/app/orderservice.env /app/orderservice.env
WORKDIR  /app

ENTRYPOINT [ "./bin/orderservice"]


