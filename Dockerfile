# syntax=docker/dockerfile:1
# to build docker image -> docker build -t crm-event-handler:1.0 ./

FROM golang:1.21.5-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /crm-event-handler-hello-world

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=builder /crm-event-handler-hello-world ./
COPY ./static/ ./static/

EXPOSE 8080

CMD ["./crm-event-handler-hello-world"]
