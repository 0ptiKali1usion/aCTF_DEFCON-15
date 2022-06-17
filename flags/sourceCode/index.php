<?php
if($_POST['input']&&$_POST['teamname']&&$_POST['submit'])
{
        echo "<p>Processing answer...</p>";
	$answer_filename = "answer";
	$handle = fopen($answer_filename, "r");
	$answer = fread($handle, filesize($answer_filename));
	fclose($handle);

	$answer = str_replace(array("\n", "\r"), array(""), $answer);
	$user_answer = str_replace(array("\n", "\r"), array(""), $_POST['input']);
	if($user_answer == $answer) {
		$flagFile = "flag.txt";
		$handle = fopen($flagFile, "w");
		fwrite($handle, $_POST['teamname'] . "\n");
		fclose($handle);
		echo $_POST['teamname']." has the flag.";
		exec("/usr/local/apache2/htdocs/changeFlag.sh");
		exit();
	} else {
		echo "<p>Wrong answer!</p>";
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
 <head>
  <title>sourceCode</title>
  <style type="text/css">
   .left  { 
    float: left;
    width: 7em;
   }
   .right {
    width: 80%;
   }
  </style>
 </head>
 <body>
  <span>Please download the code: <a href="theCode.c">theCode</a></span>
  <form action="/" name="login" method="post" style="width: 100%">
   <div style="width: 100%;">
    <span class="left">TeamName: </span>
    <span class="right"><input type="text" name="teamname" /></span>
   </div>
   <div style="width: 100%;">
    <span class="left">Input: </span>
    <span class="right">
     <textarea name="input" style="width: 80em; height: 25em;"></textarea>
    </span>
   </div>
   <div style="width: 100%;">
    <span class="left">
     <input type="submit" name="submit" value="Capture it!" />
    </span>
   </div>
  </form>
 </body>
</html>
