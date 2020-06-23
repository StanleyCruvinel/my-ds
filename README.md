# my-ds
My data science Docker image.

Experimental branch:
1) Base image: ubuntu:20.04.
2) Python 3.7: install from source.
3) GCC: version 9.3.0.

[![Python 3.7](https://img.shields.io/badge/Python-3.7-gree.svg)](https://www.python.org/downloads/release/python-370/)
[![Docker 2.2+](https://img.shields.io/badge/Docker-2.2+-blue.svg)](https://www.python.org/downloads/release/python-370/)


Base image: `python:3.7-buster`

#### To-do:
1) Pull image to DockerHub.

## Building:
To build the image:

```bash
./build.sh
```

## Running:
To run the image and set up the servers:

```bash
./run.sh
```

Wait for get the JupterLab URL access.

## Stopping:
To stop the container:

```bash
./stop.sh
```

## Run a shell in the running container: 
To stop the container:

```bash
./exec_bash.sh
```