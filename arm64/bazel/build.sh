#!/usr/bin/env sh

DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-"jbarthel"}
ARCH=${ARCH:-"arm64"}

DOCKER_CLI_EXPERIMENTAL=enabled docker \
  buildx build --platform linux/arm64 \
  --progress plain \
  --build-arg ARCH=${ARCH} \
  -t ${DOCKER_REPOSITORY}/bazel:latest-${ARCH} \
  -f Dockerfile \
  --push \
  .