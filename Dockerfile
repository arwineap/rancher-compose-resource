FROM alpine:latest

COPY check /opt/resource/check
COPY in /opt/resource/in
COPY out /opt/resource/out

RUN apk add --no-cache curl bash jq \
  && curl -Lo /tmp/rancher-compose.tar.gz  https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz \
  && tar -xf /tmp/rancher-compose.tar.gz -C /tmp \
  && mv /tmp/rancher-compose-v0.12.5/rancher-compose /usr/local/bin/rancher-compose \
  && rm -rf /tmp/rancher-compose.tar.gz /tmp/rancher-compose-v0.12.5

