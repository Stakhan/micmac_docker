FROM ubuntu:20.04
MAINTAINER eal

ENV TZ=US/Mountain
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND noninteractive


USER root

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y git make imagemagick libimage-exiftool-perl exiv2 proj-bin qt5-default cmake build-essential qttools5-dev-tools

RUN git clone https://github.com/micmacIGN/micmac.git micmac

RUN cd micmac && rm -rf build && mkdir build && cd build && \

    cmake \
    	-DBUILD_POISSON=0 \
    	-DBUILD_RNX2RTKP=0 \
    	-DWITH_OPENCL=OFF  \
    	-DWITH_OPEN_MP=OFF  \
    	-DWITH_ETALONPOLY=OFF \
    	-DWERROR=OFF \
    	../ && \
      make clean && \
      make -j$(cat /proc/cpuinfo | grep processor | wc -l) && make install && \
      mkdir /code && mkdir /code/micmac && \
      cd .. && \
      cp -Rdp bin binaire-aux lib include /code/micmac
