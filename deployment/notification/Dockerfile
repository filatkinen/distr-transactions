FROM golang:1.21-alpine as Builder
WORKDIR /usr/src/app/

COPY . /usr/src/app/
COPY ./deployment/notification/notification.env /usr/src/app/notification.env

RUN go build -v -o ./bin/notification  ./cmd/notification

FROM debian:stable-slim
COPY --from=builder /usr/src/app/bin/notification /app/bin/notification
COPY --from=builder /usr/src/app/notification.env /app/notification.env
WORKDIR  /app

ENTRYPOINT [ "./bin/notification"]


