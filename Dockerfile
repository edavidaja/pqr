FROM ubuntu:jammy

ARG R_VERSION=4.3.2
ARG QUARTO_VERSION=1.4.533
ARG PYTHON_VERSION=3.10.13

# add sysdeps from rstudio-docker-products
# https://github.com/rstudio/rstudio-docker-products/blob/3718640927a262f777646c762d1d98eba1496280/content/base/Dockerfile.ubuntu2204#L12-L79

# Locale configuration --------------------------------------------------------#
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ=UTC

# Installation prerequisites --------------------------------------------------#
# curl is used to download things.
# libev-dev is required for most interactive Python applications.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      libev-dev \
    && rm -rf /var/lib/apt/lists/*

# System dependencies needed by popular R packages
# https://docs.rstudio.com/rsc/post-setup-tool/#install-system-dependencies

# Now, install the system requirements for R packages.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      default-jdk \
      gdal-bin \
      git \
      gsfonts \
      imagemagick \
      libarchive-dev \
      libcairo2-dev \
      libcurl4-openssl-dev \
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
      libpng-dev \
      libpq-dev \
      libproj-dev \
      libsodium-dev \
      libssh2-1-dev \
      libssl-dev \
      libtiff-dev \
      libudunits2-dev \
      libv8-dev \
      libicu-dev \
      libxml2-dev \
      make \
      perl \
      tcl \
      tk \
      tk-dev \
      tk-table \
      unixodbc-dev \
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
    && curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb \
    && gdebi -n ./quarto-linux-amd64.deb \
    && rm quarto-linux-amd64.deb
