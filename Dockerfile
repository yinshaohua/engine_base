FROM ubuntu:21.10

RUN apt-get update && \
    apt-get install -y gcc && \
    apt-get install -y python3 && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple
RUN pip3 config set install.trusted-host mirrors.aliyun.com

RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache numpy scipy rsa cython

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*
