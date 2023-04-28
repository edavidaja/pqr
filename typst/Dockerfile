FROM ubuntu:jammy

ARG QUARTO_VERSION=1.4.11
ARG TYPST_VERSION=0.3.0

RUN apt-get update -y \ 
    && apt-get install -y curl gdebi-core xz-utils \
    && curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && gdebi -n ./quarto-linux-amd64.deb \
    && curl -o /tmp/typst.tar.xz -L https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz \
    && tar xf /tmp/typst.tar.xz -C /usr/local/bin/ --strip-components=1 \
    && rm quarto-linux-amd64.deb /tmp/typst.tar.xz
