#!/bin/bash
#
# Create a new set of SSH private keys to be used as a Certificate Authority.
# Require a compiled SSH to enable keys that support the -sk

export PATH=/opt/homebrew/bin:$PATH

COMMENT="yubikey-ed25519-sk.keyfob.co.slakin.net"

/opt/homebrew/bin/ssh-keygen -C ${COMMENT} -f yubikey-ca -t ed25519-sk

