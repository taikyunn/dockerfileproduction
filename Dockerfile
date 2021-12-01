# 開発環境
# gitinstallが1.15.2だとできなかった
FROM golang:1.15.2-alpine as dev

ENV ROOT=/go/src/app
# C言語のインポートを無しにする
ENV CGO_ENABLED 0
WORKDIR ${ROOT}

# gitのインストール
RUN apk update && apk add git
COPY go.mod go.sum ./
RUN go mod download
EXPOSE 3000

CMD ["go", "run", "main.go"]

# 本番環境
FROM golang:1.15.2 as builder

WORKDIR /build
COPY . /build/

RUN CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags "-s -w" -o /build/main

FROM alpine:3.9.4

# LABEL app="go-helloworld"
LABEL environment="production"
# Set workdir on current image
WORKDIR /app
# Leverage a separate non-root user for the application
RUN adduser -S -D -H -h /app appuser
# Change to a non-root user
USER appuser
# Add artifact from builder stage
COPY --from=builder /build/main /app/
# Expose port to host
EXPOSE 3000
# Run software with any arguments
ENTRYPOINT ["./main"]
