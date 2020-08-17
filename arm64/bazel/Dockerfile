FROM debian:unstable-slim as build
ARG ARCH
RUN apt update && apt install -y curl jq \
    && export RELEASE_URL=https://api.github.com/repos/bazelbuild/bazel/releases/latest \
    && curl -s ${RELEASE_URL} | jq ".assets[] | select(.name | test(\".*linux-${ARCH}\$\"))" > artifact_descriptor.json \
    && export DOWNLOAD_URL=$(jq -r '.browser_download_url' artifact_descriptor.json) \
    && curl -L ${DOWNLOAD_URL} -o bazel \
    && chmod +x bazel

FROM debian:unstable-slim as dist
RUN useradd -m bazel && usermod -L bazel \
    && apt update && apt -y python3 ca-certificates gcc g++

COPY --from=build /bazel /usr/bin/bazel
USER bazel
WORKDIR /home/bazel