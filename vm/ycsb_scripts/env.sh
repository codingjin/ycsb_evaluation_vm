#!/bin/bash
flush_fs_caches()
{
	sync;
	echo 3 | tee /proc/sys/vm/drop_caches >/dev/null 2>&1
	sleep 3
}

disable_va_aslr()
{
	echo 0 | sudo tee /proc/sys/kernel/randomize_va_space >/dev/null 2>&1
}

check_pmqos()
{
	local pmqospid=$(ps -ef | grep pmqos | grep -Ev 'sudo |grep' | awk '{print $2}')
	#set_performance_mode
	[[ -n "$pmqospid" ]] && return

	sudo nohup ./pmqos >/dev/null 2>&1 &
	sleep 3

	# double check
	pmqospid=$(ps -ef | grep pmqos | grep -Ev 'sudo |grep' | awk '{print $2}')
	if [[ -z "$pmqospid" ]]; then
		echo "Error: failed to start pmqos!"
		exit
	fi
}

disable_va_aslr

#apt install bc

#timedatectl set-timezone America/Los_Angeles

flush_fs_caches

