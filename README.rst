# docker-tesseract

|Travis|

Simple docker image that contains the new 4.0 version of tesseract.
It is compiled from git according to the specified git commit.
Acts as a base for my personal fork of paperless (so that image creation of that is significantly increased).

Usage as standalone programm:
docker run --user `id -u`:`id -g` -v `pwd`:/exchange npodewitz/docker-tesseract:4.0b <inputfile> <outputbase> <config>

This mounts the current working directory to /exchange inside the container (which ist the default directory in the container).
The --user option ensures that newly created files have the uid and gid of the user which runs the docker command.


.. |Travis| image:: https://travis-ci.org/VendettA01/docker-tesseract.svg?branch=master
   :target: https://travis-ci.org/Vendetta01/docker-tesseract
