FROM python:3.13-slim

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
    && apt-get install --no-install-recommends -qy git curl bash ca-certificates gnupg libxml2-dev libxslt-dev build-essential unzip
RUN curl -fsSL https://bun.sh/install | bash
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
