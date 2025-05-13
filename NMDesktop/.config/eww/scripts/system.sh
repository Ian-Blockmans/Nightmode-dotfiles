#!/bin/bash

get_spu_freq() {
    grep MHz /proc/cpuinfo | awk '{print $4}' | awk '{temp+=$1;n++} END{printf("%f\n", temp/n);}'
}

# Main
case "$1" in
    "--cpu-freq"       ) get_spu_freq ;;
esac





