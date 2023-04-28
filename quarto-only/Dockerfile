FROM ubuntu:jammy

ARG QUARTO_VERSION=1.3.310

RUN apt-get update -y \ 
    && apt-get install -y curl gdebi-core \
    && curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && ls -lha \
    && gdebi -n ./quarto-linux-amd64.deb
