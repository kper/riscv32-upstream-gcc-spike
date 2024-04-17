# Riscv32 gcc toolchain

This folder contains a `Dockerfile` which has the riscv toolchain and spike installed. The idea is that you put the file `main.c` into the `src` folder and it will run spike for you. Finally we run spike on it.

Steps:

* Add `main.c` to `src`
* Run `make build`
* Run `make serve`
