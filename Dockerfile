FROM ubuntu:20.04 as engine_base

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && sed -i -e 's/^APT/# APT/' -e 's/^DPkg/# DPkg/' /etc/apt/apt.conf.d/docker-clean \
    && apt-get clean \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y unicode \
    && apt-get install -y locales \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen \
    && apt-get install -y python3

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive \
    LC_ALL=en_US.UTF-8

RUN apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

FROM engine_base as engine_dev

RUN apt-get install -y gcc \
    && apt-get install -y python3-pip \
    && apt-get install -y python3-dev \
    && apt-get install -y libatlas-base-dev \
    && apt-get install -y python3-ply \
    && apt-get install -y python3-networkx
    # && rm -rf /var/lib/apt/lists/*

RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple \
    && pip3 config set install.trusted-host mirrors.aliyun.com \
    && pip3 install --no-cache -U pip \
    && pip3 install --no-cache -U numpy scipy rsa cython setuptools paramiko ujson pykalman thriftpy2

