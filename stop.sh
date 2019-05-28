#!/bin/bash

while read p; do
	kill $1 $p
	echo "killed $p"
done < ./pids
