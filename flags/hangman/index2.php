<html>
 <head>
  <title>Hangman</title>
 </head>
 <body>
<?php
  session_start();
  $count = intval(trim(file_get_contents("count.txt")));

  if($_SESSION['winner'] == "yes") {
    unset($_SESSION['winner']);
    $flag = htmlentities(escapeshellcmd($_POST['teamname']));
    exec("echo $flag > flag.txt");
    $count++;
    exec("echo $count > count.txt");
  }

  $flag = file_get_contents("flag.txt");
  if($count <= 20)
    $level = 1;
  else if($count <= 30)
    $level = 2;
  else
    $level = 3;

  echo "<h1>This flag is owned by <span style=\"color: red;\">$flag</span></h1>\n";
  echo "<h2>This flag has been captured $count times</h2>\n";
  echo "<h3 style=\"display: none;\">Difficulty currently set to: $level</h3>\n";

  if(!$_SESSION['word']) {
    $_SESSION['guesses'] = 1;

    // level 1 wordlist (letters only)
    $wordList1 = array("BIG HUGE WORD", "LARGE DUMB WORD", "SPOT THE FED",
                       "DARK TANGENT", "YOU WIN", "CRYPTIC", "COBOL",
                       "STAMINA", "SPEAKERS", "ARCHIVE", "CYNICAL",
                       "CYCLONE", "QUEEN", "EPSILON", "SPORTSMANSHIP",
                       "PERL", "MICROSHAFT", "VERILOG", "ATMEL", 
			"FOOBAR", "BEHIND YOU", "I LIKE SOCKS", 
			"I LOVE LAMP", "AFRO SAMURI", "FOURCHAN",
			"PHP FTW", "GOT ZITS", "NOT DEAD YET",
			"I PWN", "YOU PWN", "HUMAN", "GOATSE",
			"THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
			"EINS ZWEI DREI VIER FUNF SECHS SIEBEB ACHT NEUN ZEHN",
			"WORDS THAT START WITH S", "SWORDS FOR ONE HUNDRED",
			"GOD IM TIRED OF CODING", "CARL NEEDS SLEEP", "ADRIAN NEEDS A DRNK",
			"ADAM NEEDS HAPPY HARDCORE", "APRAT WANTS GRAPE JUICE", 
                  "CP IS OUT OF CONDOMS", "HAIR BRUSHES FOR ALL", "STEAMED RICE",
			"HANG THE MAN", "IS THE RANDOM", "SONY CAMERAS",
			"SKY IS BLUE", "ANGELINA JOLIE", "ACID BURN",
			"ALL YOUR BASE ARE BELONG TO US",
			"BRIBE US SERIOUSLY", "WE WANT CHIPOTLE BURRITOS",
			"NEVER GUNNA COME BACK DOWN", "ZOON BETTER THAN IPOOD",
			"ROCK OUT WITH YOUR COCK OUT", "FUCK ITUNES",
			"CP SAW YOUR MOM ON THE INTERNET", "PABST",
			"ADRIAN IS DRUNK", "ADRIAN IS THE SPEAKER", "ADRIAN",
			"KEVIN IS A NOOB", "CP PWNED YOUR MOM", "TRAINSPOTTING");



    // level 2 wordlist (letters and numbers)
    $wordList2 = array("DCG202", "CR4SH 4ND BURN", "L33T SP34K",
                       "MI55ISSIPPI", "AMAROK", "P3RL",
                       "P3NNSYLV4N1A", "B34ST1E B0YS", 
                       "POLYPH0N1C", "RH4P0SODY", "P4STEB1N", 
			"QUIESC3N7 OP3R4TING P0IN7", 
			"H4RDWAR3 DESCR1P7ION LANGU4GE", 
			"HYPERTEXT MARKUP LANGUAGE",
			 "DC949 LIKES BOOZE", "I SEPL POUR",
			"ROF|_ L4WL L0L WTF OMFG H4 H4 HA HA",
			"B33R 4 H1NT5", "GR4P3 JU1C3 NOT WINE F0R H1NTS",
			"PR0N");
    // level 3 wordlist (letters, numbers, symbols!)
    $wordList3 = array("DCG202!", "CR4SH N BURN?", "L33T SP34K",
                       "$UP3R-51Z3 ME", "CH1P0TL3'S", 
                       "ZZYZZX RD NV", 
                       "53L3CT * FR0M DU@L WHER3 N@M3 LIK3 '%SMI+H';",
			"S74RT BR1B1|/|G U5", "W|-|Y'S 7H3 R|_|M G0NE?",
			"I $N3EZED", "X 0RG", "0_O $T4K3R", "W3$7 S1DE RID3RS",
			"A74T |=A1|_", "ITS T0T4L7Y 0|<", "-_- FRU$7R4T3D?"
			"BU77$3CHS", "N0T 3ZY HUH?", "D1D J00 ...",
			"S70P DOS1NG |-|4NGM4N", "A", "B", "C", "D", "E",
			"F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
			"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", 
			"Z", "0", "1", "2", "3", "4", "5", "6", "7", "8",
			"9", "!", "@", "#", "$", "%", "^", "*", "_",
			"/B/TARD", "/B/", "4BU(U$", "NE1 H4V3 WEED?",
			"BE|_ONG 2 U5", "Y0UR B4S3", "Y4RRG R|_|M",
			"54UC3 P1_EASE?");

    $charset1 = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                      'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                      'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                      'Y', 'Z');

    $charset2 = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                      'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                      'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                      'Y', 'Z', '0', '1', '2', '3', '4', '5',
                      '6', '7', '8', '9');

    $charset3 = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                      'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                      'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                      'Y', 'Z', '0', '1', '2', '3', '4', '5',
                      '6', '7', '8', '9', '!', '@', '#', '$',
                      '%', '^', '*', '(', ')', ',', '.',
                      '?', '=', '+', '-', '_', ';', ':', '\'',
                      '"', '|', '<', '>');

    if($level == 1) {
      $_SESSION['word'] = $wordList1[rand(0, count($wordList1)-1)];
      $_SESSION['charset'] = $charset1;
    } else if($level == 2) {
      $_SESSION['word'] = $wordList2[rand(0, count($wordList2)-1)];
      $_SESSION['charset'] = $charset2;
    } else {
      $_SESSION['word'] = $wordList3[rand(0, count($wordList3)-1)];
      $_SESSION['charset'] = $charset3;
    }
  }
  $charset = $_SESSION['charset'];
  $filename_prefix = "hangman0";

  echo "<div>$maskedWord</div>";

  if($guess = $_GET['guess']) {
    $guess = strtoupper(substr($guess, 0, 1));
    $word = $_SESSION['word'];
    if(strpos($word, $guess) !== false) {
      echo "<div><img src=\"$filename_prefix" . $_SESSION['guesses'] .
           ".png\" alt=\"$filename_prefix". $_SESSION['guesses'] . 
           "\" /></div>\n";
    } else {
      $_SESSION['guesses']++;
      echo "<div><img src=\"$filename_prefix" . $_SESSION['guesses'] .
           ".png\" alt=\"$filename_prefix". $_SESSION['guesses'] . 
           "\" /></div>\n";
      if($_SESSION['guesses'] >= 7) {
        echo "<p>You are dead!</p>";
        $_SESSION['guesses'] = 1;
        unset($_SESSION['word']);
        echo "<p><a href=\"" . $_SERVER['PHP_SELF'] . "\">Play Again</a></p>\n";
      }
    }
  } else { // they didn't make a guess
    echo "<div><img src=\"$filename_prefix" . $_SESSION['guesses'] .
         ".png\" alt=\"$filename_prefix". $_SESSION['guesses'] . 
         "\" /></div>\n";
  }

  // take it out of our character set
  while(in_array($guess, $charset)) {
    $index = array_search($guess, $charset);
    $charset[$index] = null;
  }

  $maskedWord = $_SESSION['word'];

  foreach($charset as $letter) {
    $maskedWord = str_replace($letter, '_', $maskedWord);
    $buffer .= " <a href=\"" . $_SERVER['PHP_SELF'] . "?guess=" .
         $letter . "\">$letter</a> ";
  }

  echo "<div style=\"font-family: monospace; font-size: 30pt; " .
       "letter-spacing:.3em;\">$maskedWord</div>\n";  
  if(strpos($maskedWord, '_') === false && $_SESSION['word']) {
    echo "<p>You won.  Nice work.</p>\n";
    echo "<form method=\"post\" action=\"" . $_SERVER['PHP_SELF'] . "\">\n";
    echo "<input type=\"text\" name=\"teamname\" />\n";
    echo "<input type=\"submit\" name=\"submit\" />\n";
    echo "</form>\n";
    $_SESSION['winner'] = "yes";
    $_SESSION['guesses'] = 1;
    unset($_SESSION['word']);
    echo "<p><a href=\"" . $_SERVER['PHP_SELF'] . "\">Play Again</a></p>\n";
  } else {
    if($_SESSION['word'])
      echo "<div style=\"font-family: serif; font-size: 16pt;\">$buffer</div>";
  }
  $_SESSION['charset'] = $charset;
?>
 </body>
</html>
