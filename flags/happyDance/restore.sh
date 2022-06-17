#!/bin/bash
thisDir="/root/admin/flags/happyDance"

echo "Copying files"
scp -r $thisDir/html $thisDir/addons.mozilla.org/ InfectedMushroom:/var/www/

echo "Setting permissions"
ssh games "chown nobody:nobody /var/www/htdocs/*"

echo "Creating symbolic link"
ssh games "ln -sf /var/www/htdocs/hangman.php /var/www/htdocs/index.php"
