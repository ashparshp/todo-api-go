# Build stage
FROM golang:1.21 as builder

WORKDIR /app
COPY go.mod .
COPY main.go .
RUN go build -o todo-api-go

# Run stage
FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/todo-api-go .

EXPOSE 8080
CMD ["./todo-api-go"]
