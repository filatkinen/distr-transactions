FROM golang:1.21-alpine as Builder
WORKDIR /usr/src/app/

COPY . /usr/src/app/
COPY ./deployment/payment/payment.env /usr/src/app/payment.env

RUN go build -v -o ./bin/payment  ./cmd/payment

FROM debian:stable-slim
COPY --from=builder /usr/src/app/bin/payment /app/bin/payment
COPY --from=builder /usr/src/app/payment.env /app/payment.env
WORKDIR  /app

ENTRYPOINT [ "./bin/payment"]


