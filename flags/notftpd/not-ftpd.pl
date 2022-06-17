#!/usr/bin/perl -w
$|=1; # Disable buffering of STDOUT

chdir "/home/notftpd/";
$hostname  = `hostname`; chop $hostname;
$authorized = 0;
$garbage_file = "enabled";
$command = "this is a nullish string";
print "220 Solaris NT FTP server (MIPS) v2.6.19 ready\r\n";
print "Name (services1.dc949.org:someuser): ";
$username = <STDIN>; $username =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
if ($username eq "teh_scorekeep") { $garbage_file = "disabled"; }
$line_of_garbage = "$username\r\n"; &save_garbage;
print "331 Anonymous login ok, send your social security number as your password.\r\n";
print "Password: ";
$password = <STDIN>; $password =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
$line_of_garbage = "$password\r\n"; &save_garbage;
if (!($password =~ /\d\d\d-\d\d-\d\d\d\d/))
{
	print "ERROR: PEBKAC.\r\n";
	exit;
}
print "332 Now send a cellular phone number where you can be reached at 4:30 AM.\r\n";
print "Password: ";
$password = <STDIN>; $password =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
if (!($password =~ /\(\d\d\d\) \d\d\d\-\d\d\d\d/))
{
        print "ERROR: PEBKAC.\r\n";
        exit;
}
$line_of_garbage = "$password\r\n"; &save_garbage;
print "230 Anonymous access granted.\r\n";
print "Remote system type is ReactOS.\r\n";
print "Using binary mode to transfer files.\r\n";
while ($command ne "depart") { &get_and_do_command; }
print "221 Goodbye.\r\n";
exit;

sub get_and_do_command
{
	$command = <STDIN>; $command =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
	if (($command eq "depart") || ($command eq "QUIT"))
	{ $command = "depart" }
	elsif ($command eq "help") { print "500 Insufficiently l33t.\r\n"; }
	elsif (($command eq "h3lp") || ($command eq "H3LP"))
	{
		print "214-The following commands are recognized.\r\n";
		print " depart H3LP LIST NOOP PASS QUIT STAT SYST";
		if ($authorized == 1) { print " DELE T0UCH CHG"; }
		print "\r\n";
		print "214 H3lp OK.\r\n";
	}
	elsif ($command eq "list")
	{
		$path = <STDIN>; chop $path;
		&sanitize_path;
		print `ls -- $path`;
	}
	elsif ($command eq "SYST") { print "215 Haiku\r\n"; }
	elsif ($command eq "pass")
	{
		$checksum_string = `/usr/bin/cksum -o 1 /home/notftpd/.nfpass`;
		chop ($checksum_string);
		$checksum_string = $checksum_string . "\r\n";
		@checksum_parts = split / /, $checksum_string;
		$actual_checksum = $checksum_parts[0];
		print "257 Current 16-bit Sys V checksum: $checksum_string";
		$password_attempt = <STDIN>; $password_attempt =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
		$attempt_checksum_string = `echo $password_attempt | cksum -o 1`;
		@attempt_checksum_parts = split / /, $attempt_checksum_string;
		$attempt_checksum = $attempt_checksum_parts[0];
		if ($attempt_checksum eq $actual_checksum)
		{
			$authorized = 1;
			print "230 Authorization successful.\r\n";
		}
		else
		{
			print "530 Password incorrect.\r\n";
			$line_of_garbage = "$password_attempt\r\n";
			&save_garbage;
		}
	}
	elsif ($command eq "NOOP")
	{
		print "200 Please wait while doing nothing...\r\n";
		sleep rand 5;
		print "201 Done.\r\n";
	}
	elsif ($command eq "dele")
	{
		if ($authorized == 1)
		{
			$path = <STDIN>; $path =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
			&sanitize_path;
			`rm -- $path`;
		}
		else { print "530 Please authorize with PASS.\r\n"; }
	}
	elsif ($command eq "STAT")
	{
		print "211- $hostname data server status:\r\n";
		print "     OS version "; print `uname -r`;
		print "     User is currently ";
		if ($authorized != 1) { print "un"; }
		print "authorized.\r\n";
		print "211 End of status\r\n";
	}
	elsif ($command eq "t0uch")
	{
		if ($authorized == 1)
		{
			$path = <STDIN>; $path =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
			&sanitize_path;
			`touch $path`;
		}
		else { print "530 Please authorize with PASS.\r\n"; }
	}
	elsif ($command eq "chg")
	{
		if ($authorized == 1)
		{
			$new_password = <STDIN>; $new_password =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
			&sanitize_password;
			`echo $new_password > /home/notftpd/.nfpass`;
			print "258 The 32-bit checksum is now ";
			print `cksum -o 2 /home/notftpd/.nfpass`;
		}
		else { print "530 Please authorize with PASS.\r\n"; }
	}
	elsif ($command eq "?") { print "501 Did you mean to type 'help'?\r\n"; }
	elsif (($command eq "LIST") || ($command eq "PASS") || ($command eq "DELE") ||
	       ($command eq "T0UCH") || ($command eq "CHG"))
	{
		print "500 STOP SHOUTING AT ME!\r\n";
	}
	else { print "500 User is a n00b.\r\n"; }
}

sub sanitize_path
{
	$line_of_garbage = "$path\r\n"; &save_garbage;
	if ($path =~ /[|;&\(\)]/)
	{
		print "526 No funny characters, please.\r\n";
		$path = "";
	}
}

sub sanitize_password
{
	if ($new_password =~ /\W/)
	{
		print "526 No funny characters, please.\r\n";
		$new_password = "password";
	}
}

sub save_garbage
{
	if ($garbage_file eq "enabled")
	{
		open (DATA, ">>/tmp/garbage");
		print DATA $line_of_garbage;
		close DATA;
	}
}
