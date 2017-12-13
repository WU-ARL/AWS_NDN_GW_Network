#!/bin/bash

PREFIX=$1

# point home to /home/ndnsec so keys will be stored there.
if [ ! -s /home/ndnsec/unsigned_root.cert ]
then
  cmd="export HOME=/home/ndnsec; ndnsec-key-gen -n $PREFIX  > /home/ndnsec/unsigned_root.cert"
  echo "$cmd" > /tmp/root_key_gen.cmd
  sudo su - ndnsec -c "$cmd"
fi

# now self sign it
if [ ! -s /home/ndnsec/root.cert ]
then
  cmd="export HOME=/home/ndnsec/; ndnsec-sign-req ${PREFIX}   > /home/ndnsec/root.cert"
  sudo su - ndnsec -c "$cmd"
fi


