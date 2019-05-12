#!/bin/sh
echo '
  export DIR=`pwd`
  export GITHUB_REPO="minio/mc"
  export GOPATH=/home/circleci/go
  export GOROOT=/usr/local/go
  export IMAGE=mc
  export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"
  export REGISTRY=jessestuart
  export VERSION=$(curl -s https://api.github.com/repos/${GITHUB_REPO}/releases/latest | jq -r ".tag_name")
	export QEMU_VERSION="v4.0.0"
' >>$BASH_ENV
. $BASH_ENV
