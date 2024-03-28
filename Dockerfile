FROM debian:12 as builder-riscv-toolchain
ARG num_jobs=24

ENV RISCV=/opt/riscv-cross
ENV PATH=$RISCV/bin:$PATH

RUN apt update && apt upgrade -y
RUN apt install -y build-essential autoconf automake autotools-dev python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev curl device-tree-compiler curl libmpc-dev 

WORKDIR /root
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain
WORKDIR riscv-gnu-toolchain
RUN git submodule update --init --depth=1 -- gcc
RUN git submodule update --init --depth=1 -- glibc
RUN git submodule update --init --depth=1 -- binutils
RUN ./configure --with-arch=rv32gc --with-abi=ilp32 --enable-multilib --prefix=/opt/riscv-cross && make linux -j $num_jobs && make clean

# Spike

RUN apt install -y build-essential autoconf automake autotools-dev python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev curl device-tree-compiler
WORKDIR /root
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim
WORKDIR riscv-isa-sim
RUN ./configure --prefix=/opt/spike && make -j $num_jobs && make install && make clean
