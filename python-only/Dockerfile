FROM ubuntu:jammy

ARG PYTHON_VERSION=3.11.3

RUN apt-get update -y \ 
    && apt-get install -y curl build-essential \
    && curl -O https://cdn.rstudio.com/python/ubuntu-2204/pkgs/python-${PYTHON_VERSION}_1_amd64.deb \
    && apt-get install -yq --no-install-recommends ./python-${PYTHON_VERSION}_1_amd64.deb \
    && rm -f ./python-${PYTHON_VERSION}_1_amd64.deb

