#!/bin/bash
thisDir="/root/admin/flags/notftpd"

echo "Cleaing out old flag(s)"
ssh services1 "rm /home/notftpd/*"

echo "Copying files"
scp $thisDir/.nfpass services1:/home/notftpd/.nfpass
scp $thisDir/not-ftpd.pl services1:/usr/libexec/not-ftpd.pl
ssh services1 "touch /home/notftpd/dc949"

echo "Setting permissions"
ssh services1 "chmod 711 /usr/libexec/not-ftpd.pl"
ssh services1 "chmod 600 /home/notftpd/.nfpass"
ssh services1 "chown notftpd /home/notftpd/*"
