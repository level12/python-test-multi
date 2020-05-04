FROM ubuntu:18.04
MAINTAINER devteam@level12.io

RUN apt-get clean && apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# map to the source code of the app
VOLUME /opt/src
# map to the CI artificates directory
VOLUME /opt/src/.ci/artifacts
# map to the CI test reports directory
VOLUME /opt/src/.ci/test-reports

RUN apt install gnupg -y \
    && echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu bionic main" >> /etc/apt/sources.list.d/python.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F23C5A6CF475977595C89F51BA6932366A755776 \
    && apt-get update -q \
    && apt-get install -y curl git  \
        python3.6 python3.6-dev libpython3.6-dev \
        python3.7 python3.7-dev libpython3.7-dev \
        python3.8 python3.8-dev libpython3.8-dev python3.8-distutils python3.8-venv \
    && curl -fSL "https://bootstrap.pypa.io/get-pip.py" -o get-pip.py \
    && python3.6 get-pip.py \
    && python3.7 get-pip.py \
    && python3.8 get-pip.py \
    && rm get-pip.py \
    && rm -rf /var/lib/apt/lists/*

# need these libraries for lxml, PyQuery, and dbus for Keyring
# sasl, ldap, ssl for LDAP
# freetds for pymssql
RUN apt-get update -q && apt-get install -y \
    libfreetype6 \
    libjpeg-turbo8 \
    libpq5 \
    libxml2 \
    libxslt1.1 \
    libxslt1-dev \
    libffi6 \
    libcairo2 \
    libpango1.0 \
    libtiff5 \
    libgdk-pixbuf2.0-0 \
    libdbus-glib-1-dev \
    libsasl2-dev \
    python-dev \
    libldap2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# install Microsoft ODBC driver for pyodbc
RUN apt-get update -q \
    && apt-get install -y apt-transport-https ca-certificates \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -q \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && rm -rf /var/lib/apt/lists/*

# install postgres client for migration testing
RUN apt-get update && apt-get install -y wget \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y postgresql-client-9.6 postgresql-client-10 postgresql-client-11 \
    && rm -rf /var/lib/apt/lists/*

# install additional packages for build setup and troubleshooting
RUN apt-get update && apt-get install -y \
    iputils-ping \
    netcat \
    fio \
    tree \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /opt/src
CMD ["/opt/src/docker-entry"]
ENTRYPOINT ["/bin/bash"]
