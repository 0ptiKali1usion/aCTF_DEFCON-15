#!/usr/bin/perl -w
$|=1;

@hints = ("DarkTipper: Karl's password is ass. Well, 3/8 of it is, anyway."
);
@dumb_chat_lines = ("Violet: lolz",
		    "ACiDK3WL: i wanna dip my BAWLS in it!\@!\@112",
		    "ACiDK3WL: ME T0O@!1!!1!11!",
		    "snow_owl: ORLY?",
                    "dnews: bump",
		    "team_anonymous: I found a way into the FTP thing!  Will trade for tokens.",
		    "Dark_Tangent: Hey, what's going on in here?",
		    "ACiDK3WL: WTF?",
		    "Violet: tee hee",
		    "Priest: Have you guys been to the 11th floor yet?",
		    "bot: I'm totally not a bot",
		    "isst_meister: Eat Chipotle",
		    "snow_owl: Who, is there?",
		    "Violet: You guyz r funny, lol",
		    "ACiDK3WL: ASL?",
		    "protocol: Oh N0es!  I'm outta here^D",
		    "the_pwnerer: ACiDK3WL is a retard",
		    "Mr.Magoo: forklift will shift it goo",
		    "the_pwnerer: Fuck ACiDK3WL.  That guy is an asshat!",
		    "the_pwnerer: Hey Violet, where are you sitting? ;-)",
		    "Violet: 25/f/by the DJ",
		    "the_pwnerer: /kick ACiDK3WL",
		    "ACiDK3WL: THE_PWNERERER IS A FAG LOL :-P",
		    "the_pwnerer: STFU!",
		    "the_pwnerer: GTFO n00b!",
		    "SallyJane: Any good hackers in here?",
		    "Violet: LOMG! I love those! :-D",
		    "Violet: (^_^)",
		    "SallyJane: Can U hack a site 4 me?",
		    "ACiDK3WL: DUDE EBAY THAT SHYTE",
		    "ACiDK3WL: O BTW CHECK YM MYSPCA SITE",
		    "ACiDK3WL: WHERE CN I GET ROMZ???????",
		    "Violet: I'm wearing a black hat ;) Cum find me! Tee hee!",
		    "SallyJane: doea any one how to get a crdit card number?????",
		    "Violet: LMAO! R U 4 real??",
		    "SallyJane: r u a bot",
		    "***SallyJane has left the chat",
		    "***SallyJane is now INVISIBLE",
		    "***the_pwnerer is now an Operator",
		    "the_pwnerer: /self +o /auth the_pwnerer pa55word",
		    "SallyJane: pm me some l/p's plz",
		    "Priest: Where's teh bar?",
		    "ACiDK3WL: whut is the max size of a char? its fir csc125",
		    "DeVaSt8Or: ur all n00bz!1!!11!",
		    "Mr.Magoo: 0% |********************---------| 100% LOLLI.wmv",
		    "the_pwnerer: i got pr0n pm me. bdsm all that shite",
		    "**SallyJane is now known as SallyJane[AFK]",
		    "Mr.Magoo: u gotta throw ur socks in the trash b4 hey get holes in em.",
		    "protocol: Hey, is the scorekeep down? I cant pign it.",
		    "protocol: I'm seeing some weird netwrok traffic here. Is it IPXSPX or someth",
		    "z0ne_hhh: anyone knows bou ZOMBIE SCRAPPER??????????????????????????????????",
		    "SallyJane: BRB",
		    "the_pwnerer: Are the DC949 guys still giving out alcohol?",
		    "the_pwnerer: Acid, your such a fuqin noob",
		    "system: apratt has been /kicked. (misspelled 'equalibrium')",
		    "ACiDK3WL: no",
		    "PapaSmurf: isn't it about time for you to go?",
		    "-._.-'`-._Mr.George-Farthington-Jr._.-'`-._.-: How can I download a falsh vid",
		    "Plant-Gal2: I can't see what I'm typing Somebody plz pm me",
		    "SallyJane: I think it was a rhetorical question.",
		    "SallyJane: Ok, I'm back.",
		    "Mr.Magoo: I'm making a Chipotle run, should I brign anything back for any1?",
		    "PapaSmurf: YA RLY",
		    "Choco_taco: NO U!!12@!",
		    "Violet: LOL! For real realz????",
		    "PapaSmurf: its not big enuf",
		    "DeVaSt8Or: ym rainbow tabl would crack those pws in like .0000000001.002 secs",
		    "ACiDK3WL: mines a pentium5 w/750W PS,DDR2,RAID10,dual ANTECS,SIS935 mobo,Mushk",
		    "Mr.Magoo: That's too big, man...that sh*t'll kill ya",
		    "z0ne_hhh: d00d, THAT'S why t3h internets ROOL!!",
		    "z0ne_hhh: does ne1 know how to break happedance? I hav it working on myspace",
		    "THE DUDE0001: Srsly, what's up with Hippy Dance? It's like all homosexual and",
		    "z0ne_hhh: duh, AltaVista, Firendster and YahooVideo all need happy dance",
		    "Mr.Food: Tom said that you'd need the Happy Dance extension for Myspace soon",
		    "Choco_taco: THATS NOT COOL!",
		    "Mr.Food: Chipotle ROFLs my waffles",
		    "Violet: Yay! NotFTPd is fixed!"
		    "Mr.Food: NotFTPd is delicious once again!"
		    "ACiDK3WL: now that notftp is back up, does it have the same pw?"
		    "Choco_taco: if its not FTP, what is it? it's back up"
		    "protocol: what's http://services1.dc949.org/garbage.txt?"
);
$quantity_of_lines = $#dumb_chat_lines;

while (1) {
	&say_something;
	sleep rand 5;
}

sub say_something {
	$random_hundred = rand 100;
	if ($random_hundred > 98) {
		&give_hint;
	}
	else { print "$dumb_chat_lines[rand $quantity_of_lines]\r\n"; }
}

sub give_hint {
	print "$hints[rand $#hints]\r\n";
}
