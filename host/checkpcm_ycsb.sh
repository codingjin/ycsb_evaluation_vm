#!/bin/bash

BWDONE="BWDONE_YCSB"

sleep 70

while ! [[ -f "${BWDONE}" ]];do
	sleep 3
done

