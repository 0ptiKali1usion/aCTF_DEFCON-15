#!/bin/bash
thisDir="/root/admin/flags/YourSQL"

echo "Copying files"
#scp $thisDir/db.0 services3:/home/yoursql/
scp $thisDir/help services3:/home/yoursql/
scp $thisDir/commands services3:/home/yoursql/
scp -r $thisDir/bin services3:/home/yoursql/

echo "Setting permissions"
ssh services3 "chmod -R 644 /home/yoursql/*"
ssh services3 "chmod 755 /home/yoursql/bin"
ssh services3 "chmod 711 /home/yoursql/bin/*"
ssh services3 "chown yoursql:yoursql /home/yoursql/*"
