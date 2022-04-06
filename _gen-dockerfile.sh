#!/bin/sh

echo $IMAGE_VERSION

sed "s/%%IMAGE_VERSION%%/$IMAGE_VERSION/g" Dockerfile.template > dist/Dockerfile
