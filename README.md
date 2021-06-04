# Python Test Container

Testing Python apps with tox and python versions has never been so easy!

## Installed Python Versions

3.7-3.9

Older OS tags may have less recent versions.

## OS Tags

    - ubuntu1604 (you should upgrade the OS!)
    - ubuntu1804
    - latest (Ubuntu 20.04)

## Entrypoint

By default the entrypoint is whatever you mount at `/opt/src/docker-entry`.
You must put a file there or else bash will complain that there is no file.

## PIP

`pip` is installed for every Python version. The executable is under pip{short
python version}, for example, `pip3.9`.

## Testing the container

You can drop into a shell inside the container with:

```sh
$ docker run --rm -it --entrypoint=/bin/bash level12/python-test-multi
```

## Problems

File a bug report at https://github.com/level12/python-test-multi/issues
