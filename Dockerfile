ARG target
FROM $target/golang:1.12-alpine as builder

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

FROM $target/busybox

# Build-time metadata as defined at http://label-schema.org
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

COPY --from=builder /go/bin/mc /usr/bin/mc

VOLUME /home/.mc
ENTRYPOINT ["/usr/bin/mc"]
