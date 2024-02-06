# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
RUN set -xe \
    && apk add --no-cache --purge -uU \
        python3 \
        # python3-dev \
        py3-pip \
        py3-setuptools \
        py3-wheel \
        # pipx \
    && if [[ ! -e /usr/bin/python ]]; then ln -sf $(which python3) /usr/bin/python; fi \
# Install and upgrade Pip using pip, deprecated since PEP 668 (externally managed environment)
    # && python3 -m 'ensurepip' \
    # && pip3 install --no-cache-dir --upgrade pip setuptools wheel \
    && if [[ ! -e /usr/bin/pip ]]; then ln -sf $(which pip3) /usr/bin/pip; fi \
    # && apk del --purge python3-dev \
    && rm -rf /var/cache/apk/* /tmp/*
        # /usr/lib/python*/ensurepip # pipx needs these files
#
COPY root/ /
#
ENTRYPOINT ["/usershell"]
#
CMD ["python", "-V"]
