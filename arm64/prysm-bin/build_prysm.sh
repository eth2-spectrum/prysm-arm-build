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

PRYSM_VERSION=${PRYSM_VERSION:-"v1.0.0-alpha.19"}
DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-"jbarthel"}

DOCKER_CLI_EXPERIMENTAL=enabled docker \
  buildx build --platform linux/arm64 \
  --progress plain \
  --build-arg PRYSM_VERSION=${PRYSM_VERSION} \
  --build-arg PROCESSNAME=${PROCESSNAME} \
  -t ${DOCKER_REPOSITORY}/prysm-${PROCESSNAME}-arm64:${PRYSM_VERSION} \
  -f Dockerfile \
  --push \
  .