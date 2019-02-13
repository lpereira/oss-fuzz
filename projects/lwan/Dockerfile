FROM gcr.io/oss-fuzz-base/base-builder
MAINTAINER leandro.pereira@gmail.com
RUN apt-get update
RUN apt-get install -y build-essential cmake git ninja-build zlib1g-dev

RUN git clone --depth 1 git://github.com/lpereira/lwan
WORKDIR lwan

COPY build.sh $SRC/
