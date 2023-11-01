FROM golang:1.21-alpine as Builder
WORKDIR /usr/src/app/

COPY . /usr/src/app/
COPY ./deployment/warehouse/warehouse.env /usr/src/app/warehouse.env

RUN go build -v -o ./bin/warehouse  ./cmd/warehouse

FROM debian:stable-slim
COPY --from=builder /usr/src/app/bin/warehouse /app/bin/warehouse
COPY --from=builder /usr/src/app/warehouse.env /app/warehouse.env
WORKDIR  /app

ENTRYPOINT [ "./bin/warehouse"]


