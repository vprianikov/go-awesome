FROM golang:alpine AS build_base

RUN apk add --no-cache git

WORKDIR /go/src/app

COPY go.mod .
# COPY go.sum .

RUN go mod download && go mod verify

COPY . .

RUN go build -v -o /go/out/app .

FROM alpine:latest

COPY --from=build_base /go/out/app /usr/local/bin/app

CMD ["/usr/local/bin/app"]
