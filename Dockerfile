FROM alpine:3.7
# alpine:edge seems to actually be 3.7 anyway, so let's just wait for 3.8

RUN set -xe && \
    sed -i -e 's/v3\.7/edge/g' /etc/apk/repositories && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update --no-cache bash py-pip deluge@testing=1.3.15-r1 && \
    rm -rf /var/cache/apk/* && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip2 install incremental constantly packaging automat service_identity

ADD config /default-config
ADD startdeluge /usr/local/bin/startdeluge
RUN chmod 755 /usr/local/bin/startdeluge

CMD ["/usr/local/bin/startdeluge"]
