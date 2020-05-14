FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Install Wine & Winetricks
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends ca-certificates xvfb wine32 winetricks && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Turn off Fixme warnings
ENV WINEDEBUG=fixme-all

# Setup a Wine prefix
ENV WINEPREFIX=/root/statsgen
ENV WINEARCH=win32
RUN winecfg

# Install Visual C++ Redistributable
COPY install-vcrun6.sh /root/statsgen
RUN mkdir /root/statsgen/drive_c/statsgen && bash /root/statsgen/install-vcrun6.sh

#Run statsgen
ENTRYPOINT xvfb-run -a wine "/root/statsgen/drive_c/statsgen/statsgen2.exe"