NAME=riscv32-gcc-upstream-spike
pwd=$(CURDIR)

build:
	docker build -t $(NAME) .

build_podman:
	podman build -t $(NAME) .

serve:
	docker run --rm --mount source="$(pwd)/startup.sh",target=/run/startup.sh,type=bind --mount source="$(pwd)/helper",target=/helper,type=bind --mount source="$(pwd)/src/",target=/code,type=bind -it $(NAME) sh /run/startup.sh
