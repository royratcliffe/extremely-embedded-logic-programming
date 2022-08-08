FROM --platform=linux/arm/v7 alpine
RUN apk add --no-cache zlib libarchive gmp openssl3
RUN apk add --no-cache --virtual dev build-base cmake ninja \
        zlib-dev libarchive-dev gmp-dev openssl3-dev && \
    wget https://www.swi-prolog.org/download/devel/src/swipl-8.5.15.tar.gz && \
    tar xzf swipl-8.5.15.tar.gz && \
    rm swipl-8.5.15.tar.gz && \
    cd swipl-8.5.15 && \
    cmake -DINSTALL_DOCUMENTATION=OFF -B /tmp -G Ninja && \
    ninja -C /tmp && \
    cd /tmp && \
    ctest . && \
    cd /swipl-8.5.15 && \
    ninja -C /tmp install && \
    cd / && \
    rm -rf /tmp/* /swipl-8.5.15
