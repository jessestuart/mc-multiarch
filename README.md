# mc-multiarch

[![CircleCI][circleci]][circleci-link]
[![][microbadger-layer-badge]][microbadger-link]
[![][microbadger-version-badge]][microbadger-link]
[![Docker Pulls][shields]][docker]

Nightly builds of [Minio][minio]'s [`mc`][github] for cross-platform
architectures (armv7, aarch64, amd64).

### Usage

```console
$ docker run --rm -it jessestuart/mc
NAME:
  mc - Minio Client for cloud storage and filesystems.

USAGE:
  mc [FLAGS] COMMAND [COMMAND FLAGS | -h] [ARGUMENTS...]

COMMANDS:
  ls       List files and folders.
  mb       Make a bucket or a folder.
  cat      Display file and object contents.
  pipe     Redirect STDIN to an object or file or STDOUT.
  share    Generate URL for sharing.
  cp       Copy files and objects.

  [...]

VERSION:
  2018-05-28T05:40:55Z
```

Mount your local credentials directory, and you'll get a fully portable (cross
platform) and containerized S3 client. By default, the client looks for
configuration files at `/root/.mc`:

```console
# Assuming I have an "aws" host previously configured with mc:
$ docker run --rm -it -v ~/.mc:/home/.mc jessestuart/mc ls aws
[2018-02-17 19:18:35 UTC]     0B some-bucket/
[2018-03-16 04:34:54 UTC]     0B another-bucket/
[...]
```

[circleci-link]: https://circleci.com/gh/jessestuart/mc-multiarch
[circleci]: https://circleci.com/gh/jessestuart/mc-multiarch.svg?style=shield
[docker]: https://hub.docker.com/r/jessestuart/mc/
[github]: https://github.com/minio/mc
[microbadger-layer-badge]: https://images.microbadger.com/badges/image/jessestuart/mc.svg
[microbadger-link]: https://microbadger.com/images/jessestuart/mc
[microbadger-version-badge]: https://images.microbadger.com/badges/version/jessestuart/mc.svg
[minio]: https://minio.io
[shields]: https://img.shields.io/docker/pulls/jessestuart/mc.svg
