#!/usr/bin/perl -w

$command_file = "/home/yoursql/commands";
$help_file = "/home/yoursql/help";

# add a random num/char to end of comands?
@load_commands   = ("load table",    "read table",    "snarf table");
@save_commands   = ("save table",    "retain table",   "store table",   "write table", "record table");
@show_commands   = ("show table",    "display table",  "dump table",    "print table");
@add_commands    = ("add record",    "append record",  "insert record", "push record", "tack-on record");
@delete_commands = ("delete record", "remove record",  "drop record",   "ditch record");
@quit_commands   = ("quit",          "exit",           "leave",         "depart");

$load_command   =   @load_commands[int (rand 3)];
$save_command   =   @save_commands[int (rand 5)];
$show_command   =   @show_commands[int (rand 4)];
$add_command    =    @add_commands[int (rand 5)];
$delete_command = @delete_commands[int (rand 4)];
$quit_command   =   @quit_commands[int (rand 4)];

open COMMANDFILE, ">$command_file";
print COMMANDFILE "$load_command\n";
print COMMANDFILE "$save_command\n";
print COMMANDFILE "$show_command\n";
print COMMANDFILE "$add_command\n";
print COMMANDFILE "$delete_command\n";
print COMMANDFILE "$quit_command\n";
close COMMANDFILE;

# Make a list of the randomly-selected commands, and "cut the deck"
@valid_commands = ($load_command, $save_command, $show_command,
                   $add_command, $delete_command, $quit_command);
$random_command_number = int (rand 6);
for ($array_pointer = $random_command_number; $array_pointer <= $#valid_commands; $array_pointer++) {
	push (@scrambled_array, $valid_commands[$array_pointer]);
}
for ($array_pointer = 0; $array_pointer < $random_command_number; $array_pointer++) {
	push (@scrambled_array, $valid_commands[$array_pointer]);
}

open HELPFILE, ">$help_file";
print HELPFILE "YourSQL accepts the following commands:\n";
for ($array_pointer = 0; $array_pointer <= $#scrambled_array; $array_pointer++) {
	print HELPFILE "$scrambled_array[$array_pointer]\n";
}
close HELPFILE;
