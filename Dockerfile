FROM ubuntu:xenial
WORKDIR /home/dev

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    bzip2 \
    dfu-util \
    git \
    libreadline-dev \
    software-properties-common \
    unzip \
    wget
RUN apt clean
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa -y && \
    apt-get update && \
    apt-get install -y gcc-arm-embedded

RUN wget --quiet https://www.lua.org/ftp/lua-5.3.4.tar.gz -O lua.tar.gz && \
    wget --quiet https://luarocks.org/releases/luarocks-3.0.4.tar.gz -O luarocks.tar.gz
RUN tar -xzf lua.tar.gz && \
    cd lua-5.3.4 && \
    make linux test && \
    make install && \
    cd .. && \
    tar -xzpf luarocks.tar.gz && \
    cd luarocks-3.0.4 && \
    ./configure && make bootstrap && \
    cd ..
RUN luarocks install fennel

WORKDIR /target
CMD make