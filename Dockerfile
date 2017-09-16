FROM alpine:3.6

COPY . /work/

RUN cd /work && \
    apk update && \
    apk add ethtool iptables iproute2 && \
    ln -s /usr/lib/tc /lib/tc && \
    apk add python2=2.7.13-r1 py2-pip=9.0.1-r1 && \
    apk add gcc musl-dev python2-dev=2.7.13-r1 && \
    \
    cd blockade && \
    pip install -r requirements.txt && \
    python setup.py install && \
    cd .. && \
    \
    apk del gcc musl-dev python2-dev && \
    rm -r /var/cache/* && \
    \
    rm /usr/bin/nsenter && \
    ln -s $(pwd)/nsenter-2015-07-28 /usr/bin/nsenter && \
    ln -s $(pwd)/blockade-wrap      /usr/bin/

WORKDIR /blockade
ENTRYPOINT ["nsenter", "--target", "1", "--net", "blockade"]
