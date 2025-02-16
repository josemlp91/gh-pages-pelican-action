FROM python:3.12-slim

LABEL "com.github.actions.name"="Pelican for GitHub Pages"
LABEL "com.github.actions.description"="Builds and deploys the Pelican project to GitHub Pages"
LABEL "com.github.actions.icon"="home"
LABEL "com.github.actions.color"="red"

LABEL "Name"="Pelican for GitHub Pages"
LABEL "Version"="0.1.0"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install node via instructions at https://github.com/nodesource/distributions
RUN apt-get update \
    && apt-get install --no-install-recommends -qy git curl bash ca-certificates gnupg unzip build-essential

RUN curl -fsSL https://bun.sh/install | bash
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/


# Pre-requisites for Pillow, a key requirement for many python-based pelican installs.
# Per https://pillow.readthedocs.io/en/stable/installation.html#
RUN apt-get install -y \
    libffi-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-turbo-progs \
    libjpeg62-turbo-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    libtiff5-dev \
    libwebp-dev \
    libssl-dev \
    meson \
    netpbm \
    tcl8.6-dev \
    tk8.6-dev \
    xvfb \
    zlib1g-dev \
    libxml2-dev \
    libxslt-dev


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
