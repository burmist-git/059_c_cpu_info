#!/bin/bash

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d : default"
    echo " [0] -s : single live"
    echo " [0] -l : use native_cpuid"
    echo " [0] -p : watch /proc/cpuinfo"
    echo " [0] -c : clean"
    echo " [0] -h : print help"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-d" ]; then
	for i in $(seq 0 19)
	do
	    screenName="screenID$i"
            jobID=`printf "%04d" $i`
	    cmd="screen -S $screenName -L -d -m ./cpuinfo 1 $jobID $jobID.out"
	    echo "$cmd"
	    $cmd
	done
    elif [ "$1" = "-s" ]; then
	i=0
        jobID=`printf "%04d" $i`
	./cpuinfo 1 $jobID $jobID.out
    elif [ "$1" = "-l" ]; then
	./cpuinfo 2
    elif [ "$1" = "-c" ]; then
	make clean;
	rm *.out;
	rm screenlog.0
    elif [ "$1" = "-p" ]; then
	cat /proc/cpuinfo | grep "cpu MHz"
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi

