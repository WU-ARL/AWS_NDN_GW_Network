#!/bin/bash

PREFIX=$1

# point home to /var/lib/ndn/nlsr so keys will be stored there.
if [ ! -s /home/nlsr/unsigned_root.cert ]
then
  cmd="export HOME=/var/lib/ndn/nlsr/; ndnsec-key-gen -n $PREFIX  > /home/nlsr/unsigned_root.cert"
  echo "$cmd" > /tmp/root_key_gen.cmd
  sudo su - nlsr -c "$cmd"
fi

# now self sign it
if [ ! -s /home/nlsr/root.cert ]
then
  cmd="export HOME=/var/lib/ndn/nlsr/; ndnsec-sign-req ${PREFIX}   > /home/nlsr/root.cert"
  sudo su - nlsr -c "$cmd"
fi


