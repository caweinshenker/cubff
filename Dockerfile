FROM amd64/alpine:3.14
ARG CUDA=0
RUN apk add --update --no-cache pkgconfig nasm git g++ cmake make m4 python3-dev brotli brotli-libs brotli-dev && ln -sf python3 /usr/bin/python 
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools invoke pybind11
ENV PKG_CONFIG_PATH=/usr/lib/
COPY . /cubff
VOLUME /cbff
WORKDIR /cubff 
RUN make clean && make CUDA=0 PYTHON=1
WORKDIR /
RUN git clone https://github.com/ajyoon/systemf.git \
  && cd systemf \
  && make clean \
  && make build
WORKDIR /

ENTRYPOINT ["/bin/sh"]