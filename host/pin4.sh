#!/bin/bash

qemu_pid=$(ps aux | grep 'qemu-system-x86_64' | grep -Ev 'sudo qemu-system-x86_64|grep' | awk '{print $2}')
if [ -z "${qemu_pid}" ]; then
	echo "No QEMU running"
	exit
fi

sudo taskset -pc 34 ${qemu_pid};

sudo ./qmp-vcpu-pin -s ./qmp-sock 35 36 37 38


