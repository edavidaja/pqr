FROM ubuntu:jammy

ARG R_VERSION=4.4.2
ARG QUARTO_VERSION=1.6.40
ARG PYTHON_VERSION=3.13.1
ARG DEBIAN_FRONTEND=noninteractive

# Locale configuration --------------------------------------------------------#
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV TZ=UTC


# Installation prerequisites --------------------------------------------------#
# curl is used to download things.
# libev-dev is required for most interactive Python applications.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      libev-dev \
    && rm -rf /var/lib/apt/lists/*

### Update/upgrade system packages ###
RUN apt-get update --fix-missing  \
    && apt-get upgrade -yq \
    && apt-get install -yq --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        cmake \
        cracklib-runtime \
        curl \
        default-jdk \
        dirmngr \
        dpkg-sig \
        g++ \
        gcc \
        gdal-bin \
        gfortran \
        git \
        gpg \
        gpg-agent \
        gsfonts \
        imagemagick \
        jq \
        libcairo2-dev \
        libcurl4-openssl-dev \
        libev-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfribidi-dev \
        libgdal-dev \
        libgeos-dev \
        libgl1-mesa-dev \
        libglpk-dev \
        libglu1-mesa-dev \
        libgmp3-dev \
        libharfbuzz-dev \
        libicu-dev \
        libjpeg-dev \
        libmagick++-dev \
        libmysqlclient-dev \
        libopenblas-dev \
        libpaper-utils \
        libpcre2-dev \
        libpng-dev \
        libproj-dev \
        libsodium-dev \
        libssh2-1-dev \
        libssl-dev \
        libtiff-dev \
        libudunits2-dev \
        libv8-dev \
        libxml2-dev \
        locales \
        make \
        openssh-client \
        pandoc \
        perl \
        sudo \
        tcl \
        tk \
        tk-dev \
        tk-table \
        tzdata \
        unixodbc-dev \
        unzip \
        wget \
        zip \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \ 
    && apt-get install -y curl gdebi-core \
    && curl -O https://cdn.rstudio.com/r/ubuntu-2204/pkgs/r-${R_VERSION}_1_amd64.deb \
    && gdebi -n r-${R_VERSION}_1_amd64.deb \
    && rm r-${R_VERSION}_1_amd64.deb \
    && curl -O https://cdn.rstudio.com/python/ubuntu-2204/pkgs/python-${PYTHON_VERSION}_1_amd64.deb \
    && apt-get install -yq --no-install-recommends ./python-${PYTHON_VERSION}_1_amd64.deb \
    && rm -f ./python-${PYTHON_VERSION}_1_amd64.deb \
    && /opt/python/${PYTHON_VERSION}/bin/python -m pip install -U pip setuptools wheel \
    && curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && gdebi -n ./quarto-linux-amd64.deb \
    && rm quarto-linux-amd64.deb

### Clean up ###
RUN apt-get install -yqf --no-install-recommends \
&& apt-get autoremove \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*