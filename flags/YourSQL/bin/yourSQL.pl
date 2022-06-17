#!/usr/bin/perl -w
$|=1; # Disable buffering of STDOUT

$db_file = "/home/yoursql/db.0";
$command_file = "/home/yoursql/commands";
$help_file = "/home/yoursql/help";
&load_table;
&load_commands_and_help;
print "Welcome to YourSQL 1.0.\r\n\r\n";
for ($commands_left = 5; $commands_left > 0; $commands_left--) {
	print "YourSQL ($commands_left)> ";
	$input = <STDIN>; $input =~ s/(\s\s?)$//; $input = lc($input);
	if ($input eq "flag") {
		$last_record = $chopped_db[$#chopped_db];
		@flag_etc = split (/\|/, $last_record);
		print "flag: $flag_etc[3]\r\n";
	}
	elsif ($input eq $show_command) {
		$record_quantity = $#chopped_db + 1;
		print "$record_quantity records:\r\n";
		print "___ ___________ __________ ________________ ___________________________________\r\n";
		print "   |           |          |                |\r\n";
		for ($record_count = 0; $record_count <= $#chopped_db; $record_count++) {
			if ($record_count < 10) { print " "; }
			print "$record_count | ";
			@record_fields = split (/\|/, $chopped_db[$record_count]);
			$field0_gap =  9 - length ($record_fields[0]);
			$field1_gap =  8 - length ($record_fields[1]);
			$field2_gap = 14 - length ($record_fields[2]);
#			$field3_gap = 36 - length ($record_fields[3]);
			$field3_gap = 3 - length ($record_fields[3]);
			print $record_fields[0]; print " " x $field0_gap; print " | ";
			print $record_fields[1]; print " " x $field1_gap; print " | ";
			print $record_fields[2]; print " " x $field2_gap; print " | ";
			print $record_fields[3]; print " " x $field3_gap; print "\r\n";
		}
		print "___|___________|__________|________________|___________________________________\r\n";
	}
	elsif ($input eq $add_command) {
		print "Field 0> "; $field0 = <STDIN>; $field0 =~ s/(\s\s?)$//;
		print "Field 1> "; $field1 = <STDIN>; $field1 =~ s/(\s\s?)$//;
		print "Field 2> "; $field2 = <STDIN>; $field2 =~ s/(\s\s?)$//;
		print "Field 3> "; $field3 = <STDIN>; $field3 =~ s/(\s\s?)$//;
		$new_record = $field0 . "|" . $field1 . "|" . $field2 . "|" . $field3;
		push (@chopped_db, $new_record);
	}
	elsif ($input eq $save_command) {
		&save_table;
	}
	elsif ($input eq $load_command) {
		&load_table;
	}
	elsif ($input eq $delete_command) {
		print "Record #> ";
		$record_to_delete = <STDIN>; chop ($record_to_delete);
		if (($record_to_delete =~ /\d+/) && ($record_to_delete <= $#chopped_db)) {
			for ($record_count = $record_to_delete; $record_count < $#chopped_db; $record_count++) {
				$chopped_db[$record_count] = $chopped_db[$record_count + 1];
			}
			pop (@chopped_db);
		}
		else { print "Illegal record number.\n"; }
	}
	elsif (($input eq "help") || ($input eq "?")) {
		for ($help_line_number = 0; $help_line_number <= $#help; $help_line_number++) {
			$line_of_help_text = $help[$help_line_number];
			chop ($line_of_help_text);
			print "$line_of_help_text\r\n";
		}
	}
	elsif ($input eq $quit_command) { exit; }
	else { print "Unrecognized command.\r\n"; }
}

sub load_table {
	print "Loading...";
	open FLATFILE, "<$db_file";
	@db = <FLATFILE>;
	close FLATFILE;
	undef @chopped_db;
	for ($record_count = 0; $record_count <= $#db; $record_count++) {
		$chopped_record = $db[$record_count];
		chop ($chopped_record);
		push (@chopped_db, $chopped_record);
	}
	print "done.\r\n";
}
sub save_table {
	print "Saving...";
	open FLATFILE, ">$db_file";
	for ($record_count = 0; $record_count <= $#chopped_db; $record_count++) {
		print FLATFILE "$chopped_db[$record_count]\n";
	}
	close FLATFILE;
	print "done.\r\n";
}
sub load_commands_and_help {
	open COMMANDFILE, "<$command_file";
	$load_command   = <COMMANDFILE>; chop ($load_command);
	$save_command   = <COMMANDFILE>; chop ($save_command);
	$show_command   = <COMMANDFILE>; chop ($show_command);
	$add_command    = <COMMANDFILE>; chop ($add_command);
	$delete_command = <COMMANDFILE>; chop ($delete_command);
	$quit_command   = <COMMANDFILE>; chop ($quit_command);
	close COMMANDFILE;

	open HELPFILE, "<$help_file";
	@help = <HELPFILE>;
	close HELPFILE;
}
