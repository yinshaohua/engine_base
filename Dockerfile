FROM ubuntu:22.04

RUN sed -i s@/ports.ubuntu.com/ubuntu-ports/@/mirrors.aliyun.com/ubuntu-ports/@g /etc/apt/sources.list && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y gcc && \
    apt-get install -y python3 && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-pip && \
    apt-get install -y libgmp-dev && \
    apt-get install -y libatlas-base-dev && \
    apt-get install -y python3-ply && \
    apt-get install -y python3-networkx && \
    # ln -sf /usr/bin/python3.11 /usr/bin/python3 && \
    # ln -sf /usr/bin/python3.11 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple
RUN pip3 config set install.trusted-host mirrors.aliyun.com

RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache -U numpy scipy rsa cython

ENV TZ = Asia/Shanghai \
    DEBIAN_FRONTEND = noninteractive \
    LANG = "zh_CN.UTF-8"

# RUN apt update \
#     && apt install -y tzdata \
#     && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
#     && echo ${TZ} > /etc/timezone \
#     && dpkg-reconfigure --frontend noninteractive tzdata \
#     && rm -rf /var/lib/apt/lists/*
