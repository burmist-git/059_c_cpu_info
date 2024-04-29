#!/bin/bash

EXEPATHFULL="/users/lburmist/059_c_cpu_info/"

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d        : default (generate job.list with 72 jobs (for a single node))"
    echo " [0] --dscreen : default (with screen)"
    echo " [0] -s        : single live"
    echo " [0] -l        : use native_cpuid"
    echo " [0] -p        : watch /proc/cpuinfo"
    echo " [0] -c        : clean"
    echo " [0] -h        : print help"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-d" ]; then
	rm -f $EXEPATHFULL/job.list
	for i in $(seq 0 70)
	do
	    screenName="screenID$i"
            jobID=`printf "%04d" $i`
	    cmd="$EXEPATHFULL/cpuinfo 1 $jobID $EXEPATHFULL/$jobID.out" 
	    echo "$cmd"
	    echo "$cmd" >> $EXEPATHFULL/job.list
	done
    elif [ "$1" = "--dscreen" ]; then
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

