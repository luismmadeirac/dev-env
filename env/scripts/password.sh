#!/bin/bash

if [[ $1 = -m ]]; then
    for i in $(seq $2); do
        choose() { echo ${1:RANDOM%${#1}:1} $RANDOM; }

        {
            choose '!@#$%&'
            choose '0123456789'
            choose 'abcdefghijklmnopqrstuvwxyz'
            choose 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
            for i in $(seq 1 $((32 + RANDOM % 32))); do
                choose '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
            done

        } | sort -R | awk '{printf "%s",$1}'
        echo ""
    done
else

    choose() { echo ${1:RANDOM%${#1}:1} $RANDOM; }

    {
        choose '!@#$%&'
        choose '0123456789'
        choose 'abcdefghijklmnopqrstuvwxyz'
        choose 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        for i in $(seq 1 $((8 + RANDOM % 8))); do
            choose '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
        done

    } | sort -R | awk '{printf "%s",$1}'
    echo ""

fi
