# syntax=docker/dockerfile:1
# to build docker image -> docker build -t go-with-dataweave:1.0 ./

FROM golang:1.21.5-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /go-with-dataweave

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=builder /go-with-dataweave ./

EXPOSE 8080

CMD ["./go-with-dataweave"]
