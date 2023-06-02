FROM ubuntu:jammy

ARG R_VERSION=4.3.0

RUN apt-get update -y \ 
    && apt-get install -y curl gdebi-core \
    && curl -O https://cdn.rstudio.com/r/ubuntu-2204/pkgs/r-${R_VERSION}_1_amd64.deb \
    && gdebi r-${R_VERSION}_1_amd64.deb

