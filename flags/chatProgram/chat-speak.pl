#!/usr/bin/perl -w
$|=1;

&create_username;
print "Your nick is now: $username\n";
while (1) {
	$input = <STDIN>;
	if ($input =~ /quit/) { exit; }
	open (CHATLOGFILE, ">>/home/chat/chat.txt");
	print CHATLOGFILE "$username: $input";
	close CHATLOGFILE;
	open (GARBAGEFILE, ">>/jail1/tmp/garbage");
	print GARBAGEFILE "$username: $input";
	close GARBAGEFILE;
}

sub create_username {
	$username = "";
	if (int(rand 2)) { &pick_title; }
	if (int(rand 2)) { &pick_adjective; }
	&pick_noun;
	if (int(rand 2)) { &pick_number; }
}

sub pick_title {
	@titles = ("mr.", "Mrs.", "Ms.", "miss_", "Dr.", "t3h_", "some_",
	           "A_", "ye_", "Prof.");
	$title_number = int(rand $#titles + 1);
	$username = $titles[$title_number];
}

sub pick_adjective {
	@adjectives = ("big_", "Fancy_", "sexy_", "Smelly_", "good_",
	               "Hungry_", "sphincter_", "HAP-E_", "L33t_", "lonely_");
	$adjective_number = int(rand $#adjectives + 1);
	$username = $username . $adjectives[$adjective_number];
}

sub pick_noun {
	@nouns = ("pants", "th1ng", "fingers", "b1tz", "M4n",
	          "w0m4n", "D0GG", "k1TT3n", "car", "Southerner", "grrl");
	$noun_number = int(rand $#nouns + 1);
	$username = $username . $nouns[$noun_number];
}

sub pick_number {
	$number = int(rand 10000);
	$username = $username . $number;
}
