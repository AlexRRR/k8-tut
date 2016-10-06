#!/bin/sh
mkdir -p /state
echo "sleeping 30 seconds"
sleep 30
echo "Now I am ready...."
echo "OK" > /state/state.run
tail -f /dev/null
