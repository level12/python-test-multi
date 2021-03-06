# Python Test Container

Testing Python apps with tox and python versions has never been so easy!

## Installed Python Versions
    - 2.7
    - 3.6-3.8

## Entrypoint

By default the entrypoint is whatever you mount at `/opt/src/docker-entry`.
You must put a file there or else bash will complain that there is no file.

## PIP

`pip` is installed for every Python version. The executable is under pip{short
python version}, for example, `pip2.7` and `pip3.3`.

## Testing the container

You can drop into a shell inside the container with:

```sh
$ docker run --rm -it --entrypoint=/bin/bash level12/python-test-multi
```

## Problems

File a bug report at https://github.com/level12/python-test-multi/issues
