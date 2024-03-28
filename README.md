This folder contains a `Dockerfile` which has the riscv toolchain and spike installed. The idea is that you put the file `main.c` into the `src` folder and it will run spike for you. Since the lcb is not able to cross compile, we use the lcb to generate assembly then make it lowercase then compile it with the toolchain. Finally we run spike on it.

Steps:

* Add `main.c` to `src`
* Run `docker build -f Dockerfile -t riscv32-upstream-gcc-spike`
* Run `sh i_have_c_file_and_I_want_to_compile_and_simulate_with_the_upstream_gcc_toolchain.sh`