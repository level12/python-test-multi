FROM ubuntu:14.04

ENV TOX_VERSION=2.3.1

## A directory to dump TOX and coverage information
VOLUME /opt/artifacts
VOLUME /opt/src


# The pypy installation is messing with CPython setup, so at this point it is
# commented out. The installation works but it "clobbers" the pip2.7 binary
# which we need
RUN    echo 'deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main' >> /etc/apt/sources.list.d/python.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C \
    && apt-get update -q \
    && apt-get install -y curl git python3.5 python3.3 python2.7 \
    # && echo 'deb http://ppa.launchpad.net/pypy/ppa/ubuntu trusty main' >> /etc/apt/sources.list.d/python.list \
    # && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68854915 \
    # && apt-get install -y pypy \
    && curl -fSL "https://bootstrap.pypa.io/get-pip.py" -o get-pip.py \
    && python2.7 get-pip.py \
    && python3.3 get-pip.py \
    && python3.4 get-pip.py \
    && python3.5 get-pip.py \
    # && mv /usr/local/bin/pip2.7 /usr/loca/bin/cpip2.7 \
    # && pypy get-pip.py \
    # && mv /usr/local/bin/pip /usr/local/bin/pippypy \
    # && mv /usr/local/bin/cpip2.7 /usr/loca/bin/pip2.7 \
    && rm get-pip.py

RUN pip2.7 install --upgrade --force-reinstall --quiet tox==${TOX_VERSION}

WORKDIR /opt/src
ENTRYPOINT ["tox"]
CMD ["--help"]
