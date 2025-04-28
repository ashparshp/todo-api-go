# Build stage
FROM golang:latest AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .

# 👇 THIS LINE IS IMPORTANT
RUN GOOS=linux GOARCH=amd64 go build -o todo-api-go

# Run stage
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/todo-api-go .

EXPOSE 8080

CMD ["./todo-api-go"]