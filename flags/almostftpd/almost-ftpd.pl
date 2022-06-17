#!/usr/bin/perl -w
$|=1; # Disable buffering of STDOUT

$correct_user = "kjamison";
$correct_password = "password";
$password_entered = "";
$username_entered = "";
chdir "/home/kjamison";
print "220 Kon bon wa. You no Karl Jamison, you no enter!\r\n";
while (!($username_entered eq $correct_user &&
         $password_entered eq $correct_password)) {
	$input = <STDIN>; $input =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
	if ($input =~ /^[uU][sS][eE][rR] .+/) {
		@username_entered_parts = split /[uU][sS][eE][rR] /, $input;
		$username_entered = $username_entered_parts[1];
		print "331 Asswordpay?\r\n";
		$input = <STDIN>; $input =~ s/(\s\s?)$//; # Ditch newline AND/or car.ret.
		if ($input =~ /^[pP][aA][sS][sS] .+/) {
			@password_entered_parts = split /[pP][aA][sS][sS] /, $input;
			$password_entered = $password_entered_parts[1];
			if (($password_entered ne $correct_password) ||
                            ($username_entered ne $correct_user)) {
				print "530 Mot de passe incorrect.\r\n";
			}
		}
		else {
			print "530 Bitte logon mit USER und PASS.\r\n";
		}
	}
	elsif ($input =~ /^[pP][aA][sS][sS] .+/) {
		print "530 Inizio attivita con USER in primo luogo.\r\n";
	}
	elsif ($input =~ /[qQ][uU][iI][tT]/) {
		print "221 Adeus.\r\n";
		exit;
	}
	elsif ($input =~ /^[fF][lL][aA][gG]$/) {
		print `cat /home/kjamison/flag`; print "\r\n";
	}
	else {
		print "530 Bitte logon mit USER und PASS.\r\n";
	}
}
print "230 Conexion acertada.\r\n"; # Successfully logged in

while (1) {
	$input = <STDIN>; $input =~ s/\r?\r\n$//; # Ditch newline AND/or car.ret.
	if ($input =~ /^[pP][wW][dD]$/) {
		&pick_a_random_yo_momma_joke;
		print "257 /$yo_momma_joke\r\n";		
	}
	elsif ($input =~ /^[qQ][uU][iI][tT]$/) {
		print "221 Annyeonghi kaseyo. Ahn yawng hee kah seh yoh.\r\n";
		exit;
	}
	elsif ($input =~ /^[hH][eE][lL][pP]$/) {
		print "214-The following commands are recognized.\r\n";
		print " ABOR CDUP DELE FLAG HELP MDTM MKD MODE NOOP PASV PWD QUIT RMD SIZE\r\n";
		print " STAT SYST TYPE USER\r\n";
		print "214 Help OK.\r\n";
	}
	elsif ($input =~ /^[sS][yY][sS][tT]$/) {
		print "215 UNIX Type: L8\r\n";
	}
	elsif ($input =~ /^[tT][yY][pP][eE] [iI]$/) {
		print "200 Switching to Binary mode.\r\n";
	}
	elsif ($input =~ /^[pP][aA][sS][vV]$/) {
#		$random=int(rand 254)+1;
#		print "227 Entering Passive Mode (192,168,192,$random,0,22)\r\n";
		print "227 Entering Passive Mode (192,168,192,23,37,21)\r\n";
	}
	elsif ($input =~ /^[aA][bB][oO][rR]$/) {
		print "225 No transfer to ABOR.\r\n";
	}
	elsif ($input =~ /^[mM][kK][dD]/) {
		print "550 No.\r\n";
	}
	elsif ($input =~ /^[rR][mM][dD]/) {
		print "550 No.\r\n";
	}
	elsif ($input =~ /^[sS][iI][zZ][eE] /) {
		$pathname = substr $input, 5;
		$size_parts_raw = `/bin/ls -l $pathname`;
		@size_parts = split /\s+/, $size_parts_raw;
		print "213 $size_parts[4]\r\n";
	}
	elsif ($input =~ /^[mM][dD][tT][mM]/) {
		print "550 Could not get file modification time.\r\n";
	}
	elsif ($input =~ /^[rR][eE][tT][rR]/) {
		print "550 Failed to open file.\r\n";
	}
	elsif ($input =~ /^[sS][tT][aA][tT]$/) {
		print "211-FTP server status:\r\n";
		print "     Logged in as $correct_user\r\n";
		print "     TYPE: BINARY\r\n";
		print "     No session bandwidth limit\r\n";
		print "     Control connection is plain text\r\n";
		print "     Data connections are not implemented\r\n";
		print "     PukemFTPd 0.9 - cuz only closed-source software reaches version 1\r\n";
		print "211 End of status\r\n";
	}
	elsif ($input =~ /^[lL][iI][sS][tT]$/) {
#		print "150 Tous votre <<directory>> sont <<belong to us>>\r\n";
#		sleep 3;
		$list = `ls -al`;
		$list =~ s/\n/\r\n/;
		print $list;
		print "226 Le directoire est fini.\r\n";
	}
	elsif ($input =~ /^[fF][lL][aA][gG]$/) {
		print `cat /home/kjamison/flag`; print "\r\n";
	}
	elsif ($input =~ /^[cC][dD][uU][pP]$/) {
		print "250 Directory successfully changed. NOT!\r\n";
	}
	elsif ($input =~ /^[nN][oO][oO][pP]$/) {
		print "200 NOOP ok.\r\n";
	}
	elsif ($input =~ /^[dD][eE][lL][eE]/) {
		print "550 No.\r\n";
	}
	elsif ($input =~ /^[cC][wW][dD]/) {
		print "250 Directory successfully changed. Or perhaps not.\r\n";
	}
	elsif ($input =~ /^[pP][oO][rR][tT]/) {
		print "500 PORT command failed. Use passive transfers.\r\n";
	}
	else {
		print "500 Onbekend bevel > $input <\r\n";
	}
}

exit;

sub pick_a_random_yo_momma_joke {
	@yo_momma_jokes = (
		"yo_mama_so_clumsy_she_got_tangled_up_in_a_cordless_phone",
		"yo_mama_is_missing_a_finger_and_cant_count_past_nine",
		"yo_mama_breath_smell_so_bad_when_she_yawns_her_teeth_duck",
		"yo_mama_so_stupid_it_took_her_2_hours_to_watch_60_minutes",
		"yo_mama_so_stupid_when_your_dad_said_it_was_chilly_outside_she_ran_outside_with_a_spoon",
		"yo_mama_so_stupid_she_got_stabbed_in_a_shoot_out",
		"yo_mama_so_stupid_she_took_the_Pepsi_challenge_and_chose_Jif",
		"yo_mama_so_dirty_she_has_to_creep_up_on_bathwater",
		"yo_mama_so_nasty_I_called_her_to_say_hello_and_she_ended_up_giving_me_an_ear_infection"
	);
	$joke_number = int(rand 9);
	$yo_momma_joke = $yo_momma_jokes[$joke_number];
}
