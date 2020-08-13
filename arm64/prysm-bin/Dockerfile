FROM debian:unstable-slim as dist

ARG PRYSM_VERSION
ARG PROCESSNAME
WORKDIR /prysm
RUN apt update && apt install -y curl \
    && adduser --system --group app && chown -R app:app /prysm \
    && chown -R app:app /prysm

USER app
RUN curl https://prysmaticlabs.com/releases/${PROCESSNAME}-${PRYSM_VERSION}-linux-arm64 --output prysm-process \
    && chmod +x prysm-process
ENTRYPOINT ["./prysm-process"]