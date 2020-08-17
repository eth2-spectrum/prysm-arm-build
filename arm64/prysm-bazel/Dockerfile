ARG BAZEL_ARCH
FROM jbarthel/bazel:latest-${BAZEL_ARCH} AS build
ARG PROCESS
ARG ARCH
ARG COMMITISH
ARG COMMITISH_DATE
USER root
RUN apt update && apt install -y git linux-headers-${ARCH}
USER bazel
WORKDIR /home/bazel
RUN git clone --shallow-since ${COMMITISH_DATE} https://github.com/prysmaticlabs/prysm.git \
        && cd prysm \
        && git checkout ${COMMITISH} \
        && bazel build //${PROCESS}:${PROCESS}

FROM debian:unstable-slim AS dist
ARG PROCESS
ARG ARCH
RUN useradd -m prysm && usermod -L prysm \
    && apt update && apt install -y ca-certificates
COPY --from=build /home/bazel/prysm/bazel-bin/${PROCESS}/linux_${ARCH}_stripped/${PROCESS} /usr/bin/prysm_process
USER prysm
ENTRYPOINT ["prysm_process"]