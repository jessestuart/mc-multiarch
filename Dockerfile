ARG target
FROM golang:1.12-alpine as builder

ARG goarch
ENV GOARCH $goarch
ENV GOPATH /go
ENV CGO_ENABLED 0
ENV GO111MODULE on

WORKDIR /go/src/github.com/minio/

RUN \
  apk add --no-cache git && \
  git clone https://github.com/minio/mc && cd mc && \
  go build -v -ldflags "$(go run buildscripts/gen-ldflags.go)" -o /mc

FROM $target/alpine

COPY qemu-* /usr/bin/

COPY --from=builder /mc /usr/bin/mc

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL \
  maintainer="Jesse Stuart <hi@jessestuart.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.url="https://hub.docker.com/r/jessestuart/mc/" \
  org.label-schema.vcs-url="https://github.com/jessestuart/mc-multiarch" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN  \
  apk add --no-cache ca-certificates && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENTRYPOINT ["mc"]
