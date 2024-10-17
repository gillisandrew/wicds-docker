FROM debian:bookworm-slim

RUN dpkg --add-architecture i386

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        gnupg \
        curl \
        cabextract \
        unzip \
        winbind \
        xvfb \
        x11-utils \
        xdotool \
    && apt-get clean

    
# Install wine
ARG wine_version=9.0.0.0~bookworm-1
RUN curl -s https://dl.winehq.org/wine-builds/winehq.key > /etc/apt/keyrings/winehq-archive.key \
    && curl -s https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources > /etc/apt/sources.list.d/winehq-bookworm.sources \
    && apt-get update \
    && apt-get install -y --install-recommends \
        wine-stable-i386=${wine_version} \
        winehq-stable=${wine_version} \
    && apt-get clean

# Install wine-mono
ARG mono_version=8.1.0
RUN mkdir -p /usr/share/wine/mono && cd /usr/share/wine/mono \
    && curl -sO https://dl.winehq.org/wine/wine-mono/${mono_version}/wine-mono-${mono_version}-x86.msi

ENV WINEARCH=win32


RUN xvfb-run wineboot --update && xvfb-run wineserver --wait

RUN apt-get update \
&& apt-get install -y --install-recommends \
x11-apps \
imagemagick \
&& apt-get clean

ADD install_files /tmp/install_files
RUN sh /tmp/install_files/install.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
