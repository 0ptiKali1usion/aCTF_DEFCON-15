#!/bin/bash
thisDir="/root/admin/flags/almostftpd"

echo "Copying files"
scp $thisDir/flag services2:/home/kjamison/flag
scp $thisDir/almost-ftpd.pl services2:/usr/libexec/almost-ftpd.pl

echo "Setting permissions"
ssh services2 "chmod 711 /usr/libexec/almost-ftpd.pl"
ssh services2 "chmod 644 /home/kjamison/flag"
ssh services2 "chown kjamison /home/kjamison/flag /usr/libexec/almost-ftpd.pl"
