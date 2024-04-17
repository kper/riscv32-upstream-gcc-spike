#!/bin/bash
set -e

echo "This is the program which will be run..."
cat /code/main.c

/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -c -O2 -march=rv32im_zicsr -mabi=ilp32 -o /code/main.o /code/main.c
/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -c -O2 -march=rv32im_zicsr -mabi=ilp32 -o /code/init.o /helper/init.s
/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -c -O2 -march=rv32im_zicsr -mabi=ilp32 -o /code/trap.o /helper/trap.s
/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -c -O2 -march=rv32im_zicsr -mabi=ilp32 -o /code/vars.spike.o /helper/vars.spike.s
/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -c -O2 -march=rv32im_zicsr -mabi=ilp32 -o /code/common.o /helper/common.c
/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-gcc -static -nostartfiles -T/helper/link.ld /code/init.o /code/trap.o /code/vars.spike.o /code/common.o /code/main.o -o /code/main

/opt/riscv-cross/bin/riscv32-unknown-linux-gnu-objdump -d /code/main

file /code/main
readelf -h /code/main

echo "Compilation was ok"
echo "Running spike..."

/opt/spike/bin/spike -d --isa=rv32im /code/main
echo "Status Code is $?"
