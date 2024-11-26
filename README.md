# ssh-ca

# CA Setup
Generate the CA private & public keypair using the `gen_new_CA.sh` script. This script uses:
- A FIDO spec 2FA physical key, with a PIN set for the key.
- A ed25519-sk key type.

It is recommended you use a long 128 character passphrase.

## Tips
1. Keep the private key on the machine it is generated on.
2. If using MacOS, install xcode and HomeBrew, then build openssh from homebrew so you can use ssh-keygen with the -sk resident hardware keys.

```
gen_new_CA.sh to create the keypair.
```

# Server setup
Copy sshd_config.d.ca.conf to /etc/ssh/sshd_config.d/ca.conf or append to your sshd_config.
Copy the public key `yubikey-ca.pub` to `/etc/ssh/ca.pub` on the target server.
```
# Verify the sshd_config file/configuration is valid
sshd -T | grep trustedusercakeys
SSHD_LINT_RETURN=$?

# if previous commands show `trustedusercakeys /etc/ssh/ca.pub` and 0 , then restart sshd. 
if [ $SSHD_LINT_RETURN -eq 0 ];then 
  systemctl restart sshd
fi
```


# Sign a client SSH public key
Run `./sign.sh users/joe.pub joe` to generate a certificate. This will create file `users/joe-cert.pub`.
Make sure to share the contents of that certificate with Joe. 


