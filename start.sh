echo "root:$PASSWORD" | chpasswd

HOSTKEYCONF=/env/ssh/sshd_config.d/sshd_hostkey.conf

if [ ! -e $HOSTKEYCONF ]; then
    echo "#Never edit this file!" > $HOSTKEYCONF
fi

if [ -n "$RSAKEY" ] && [ ! -e $RSAKEY ]; then
    ssh-keygen -t rsa -P "" -b 4096 -f $RSAKEY
    echo "HostKey $RSAKEY" >> $HOSTKEYCONF
fi

if [ -n "$ECDSAKEY" ] && [ ! -e $ECDSAKEY ]; then
    ssh-keygen -t ecdsa -P "" -b 256 -f $ECDSAKEY
    echo "HostKey $ECDSAKEY" >> $HOSTKEYCONF 
fi

if [ -n "$ED25519KEY" ] && [ ! -e $ED25519KEY ]; then
    ssh-keygen -t ed25519 -P "" -f $ED25519KEY
    echo "HostKey $ED25519KEY" >> $HOSTKEYCONF 
fi

if [ -n "$GITUSERNAME" ]; then
    git config --global user.name "$GITUSERNAME"
fi

if [ -n "$GITUSEREMAIL" ]; then
    git config --global user.email "$GITUSEREMAIL"
fi

/usr/sbin/sshd -D