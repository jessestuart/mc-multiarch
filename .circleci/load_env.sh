#!/bin/sh
echo 'export GITHUB_REPO="minio/mc"' >> $BASH_ENV
echo 'export GOPATH=/home/circleci/go' >> $BASH_ENV
echo 'export GOROOT=/usr/local/go' >> $BASH_ENV
echo 'export IMAGE=mc' >> $BASH_ENV
echo 'export REGISTRY=jessestuart' >> $BASH_ENV
echo 'export VERSION=$(curl -s https://api.github.com/repos/${GITHUB_REPO}/releases/latest | jq -r ".tag_name")' >> $BASH_ENV
echo 'export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"' >> $BASH_ENV
echo 'export DIR=`pwd`' >> $BASH_ENV
source $BASH_ENV
