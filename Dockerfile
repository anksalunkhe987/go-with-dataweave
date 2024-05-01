# syntax=docker/dockerfile:1
# to build docker image -> docker build -t crm-event-handler:1.0 ./

FROM golang:1.21.5-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /crm-event-handler-hello-world

FROM alpine:latest

# Install DataWeave CLI and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && curl -sSL https://github.com/mulesoft-labs/data-weave-cli/releases/download/v1.0.34/dw-1.0.34-Linux | tar zxvf - -C /usr/local/bin \
    && chmod +x /usr/local/bin/dw

RUN apk --no-cache add ca-certificates

COPY --from=builder /crm-event-handler-hello-world ./
COPY ./static/ ./static/

EXPOSE 8080

CMD ["./crm-event-handler-hello-world"]
