#!/bin/bash

WD=$PWD

cd $WD/output/MQTT/broker/ && ./broker &
echo $! > pids
cd $WD/output/MQTT/orderProcessor/ && ./orderProcessor &
echo $! >> pids
cd $WD/output/MQTT/orderPrinter/ && ./orderPrinter &
echo $! >> pids
cd $WD/output/MANAGER/ && ./manager &
echo $! >> pids
cd $WD/output/SERVER/ && ./server &
echo $! >> pids
