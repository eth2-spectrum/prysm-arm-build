#!/usr/bin/env sh

case $1
in
  "beacon-chain")
    PROCESSNAME=$1;;
  "validator")
    PROCESSNAME=$1;;
  "slasher")
    PROCESSNAME=$1;;
esac

if [ ! "${PROCESSNAME}" ]
then
  echo "Usage: ./build_prysm.sh $0 {beacon-chain|validator|slasher}"
  exit 1
fi

COMMITISH=${COMMITISH:-"v1.0.0-alpha.22"}
COMMITISH_DATE=${COMMITISH_DATE:-"2020-08-15"}
DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-"jbarthel"}

DOCKER_CLI_EXPERIMENTAL=enabled docker \
  buildx build --platform linux/arm64 \
  --progress plain \
  --build-arg BAZEL_ARCH="arm64" \
  --build-arg PROCESS=${PROCESSNAME} \
  --build-arg ARCH="arm64" \
  --build-arg COMMITISH=${COMMITISH} \
  --build-arg COMMITISH_DATE=${COMMITISH_DATE} \
  -t ${DOCKER_REPOSITORY}/prysm-${PROCESSNAME}-arm64:${COMMITISH} \
  -f Dockerfile \
  --push \
  .