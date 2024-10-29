FROM ubuntu:noble

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    WINEDEBUG=fixme-all \
    WINEPREFIX=/root/statsgen \
    WINEARCH=win32

# Install dependencies and clean up
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        ca-certificates \
        xvfb \
        wine32 \
        cabextract \
        winetricks && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy installation script and run it
COPY install-vcrun6.sh /root/statsgen/install-vcrun6.sh
RUN mkdir -p /root/statsgen/drive_c/statsgen && \
    bash /root/statsgen/install-vcrun6.sh && \
    rm /root/statsgen/install-vcrun6.sh

# Run Wine configuration
RUN winecfg

# Set entrypoint
ENTRYPOINT xvfb-run -a wine "/root/statsgen/drive_c/statsgen/statsgen2.exe"
