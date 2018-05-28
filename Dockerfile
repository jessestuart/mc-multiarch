ARG target
FROM $target/golang:1.10.2-alpine as builder

LABEL maintainer="Jesse Stuart <hi@jessestuart.com>"

COPY qemu-* /usr/bin/

ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin
ENV CGO_ENABLED 0

WORKDIR /go/src/github.com/minio/

RUN \
     apk add --no-cache ca-certificates && \
     apk add --no-cache --virtual .build-deps git && \
     echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
     go get -v -d github.com/minio/mc && \
     cd /go/src/github.com/minio/mc && \
     CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main . && \
     go install -v -ldflags "$(go run buildscripts/gen-ldflags.go)"

FROM gcr.io/distroless/base

COPY --from=builder /go/bin/mc /mc

CMD ["/mc"]
