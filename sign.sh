#!/bin/bash

# Matt Snow <mattsnow@gmail.com>
# Updated: November 25, 2024
#
# A script to sign public SSH key by generating a PKI certificate with ssh-keygen.
#
# Usage: sign.sh relative/path/to/public/key.pub <userid>


# Certify (sign) a public key using the specified CA key.
SIGN_WITH_KEY="-s yubikey-ca"

# Validity interval. 
VALIDITY="-V +90d"

# Principals. Sets the user or host names to be included in cert when signing.
# Use comma separation to set multiple principals.
PRINCIPALS="-n msnow,ubuntu"

# Host key option. If set, the hostkey from the principal is enforced.
#HOST_KEY="-h"

# Serial number for certificate.
SERIAL="-z $(date +%s)"

# certificate identity when signing.
#IDENTITY="-I $2" # The identity/user of the cert
IDENTITY="-I msnow" # The identity/user of the cert

# Additional restrictive options.
# Update the message in /usr/bin/ssh-no-pty.sh
#OPTIONS="-O no-port-forwarding -O no-pty -O no-x11-forwarding -O permit-agent-forwarding -O no-user-rc -O force-command=/usr/bin/ssh-no-pty.sh"
OPTIONS="-O permit-agent-forwarding"

INPUT_PUBLIC_KEY="$1"

if [ -f "${INPUT_PUBLIC_KEY}" ]; then
    echo "Signing public key"
    /opt/homebrew/bin/ssh-keygen ${SIGN_WITH_KEY} ${VALIDITY} ${PRINCIPALS} ${OPTIONS} ${SERIAL} ${IDENTITY} ${INPUT_PUBLIC_KEY}
elif [ ! -f "${INPUT_PUBLIC_KEY}" ]; then
    echo "No public key to sign."
    exit 1
fi
