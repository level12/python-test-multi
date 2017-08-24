# Python Test Container

Testing Python apps with tox and python versions has never been so easy!

## Quick Start

```sh
$ docker run --volume=/path/to/source:/opt/src level12/python-test-multi -e py27,py33,py34,py35,py36,pypy
```

## Installed Python Versions
    - 2.7.6
    - 3.3.6
    - 3.4.3
    - 3.5.1
    - 3.6.1
    - pypy 2.2.1 (2.7.3)

## Entrypoint

The entrypoint is a python2.7 tox installation. By default the container pins
the tox version to 2.3.1. You can rebuild the container adjusting the
`TOX_VERSION` environment variable to suit your needs.

## PIP

`pip` is installed for every Python version. The executable is under pip{short
python version}, for example, `pip2.7` and `pip3.3`. PyPy also has pip
installed and is accessible from `pippypy`. A `pip` command is not available to
avoid possible version mismatches. You wont need pip since tox is the entrypoint
anyway, but it is worth noting.

## Testing the container

You can drop into a shell inside the container with:

```sh
$ docker run -it --entrypoint=/bin/bash level12/python-test-multi
```

## Problems

File a bug report at https://github.com/level12/python-test-multi/issues
