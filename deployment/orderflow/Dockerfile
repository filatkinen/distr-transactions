FROM golang:1.21-alpine as Builder
WORKDIR /usr/src/app/

COPY . /usr/src/app/
COPY ./deployment/orderflow/orderflow.env /usr/src/app/orderflow.env

RUN go build -v -o ./bin/orderflow  ./cmd/orderflow

FROM debian:stable-slim
COPY --from=builder /usr/src/app/bin/orderflow /app/bin/orderflow
COPY --from=builder /usr/src/app/orderflow.env /app/orderflow.env
WORKDIR  /app

ENTRYPOINT [ "./bin/orderflow"]


