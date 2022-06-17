<?php

// DC949 aCTF3 Challenge
// Happy Dance (HackBak) service
// By CP
//
//
//
//


require_once ('mysql_connect.php');

$debug=0;
$alerts=0;
$add_authed_keys=1;
$remove_authed_keys=1;
$submit_dump_shit=1;
$kpp=443;
$XORKey=1;
$num=rand(100,995);//Create random key location from 100-995
$sendCommand=1;
$commandCrypt=1;




$default=	"This is a test of the DC949 alert system. If you have decoded this messege, My hats off to you. -CP";
$restart=	"Components.classes['@mozilla.org/toolkit/app-startup;1'].getService(Components.interfaces.nsIAppStartup).quit(Components.interfaces.nsIAppStartup.eRestart|Components.interfaces.nsIAppStartup.eAttemptQuit);";
$quit=		"goQuitApplication();";
$alert=		"alert('wake up neo...');";
$holyhell_l=	"for(i=0; i<1000; i++)moveTo(Math.random()*500,Math.random()*500);";
$holyhell=	"for(i=0; i>-5; i++)moveTo(Math.random()*500,Math.random()*500);i--;";
$ar=		"alert('server side command');";
// getBrowser().addTab('URL');
// getBrowser().loadURI('URL');

$command= $default;

if($_POST['key'])// Decrypt XOR encrypted authKey 
	{
	$keyy=$_POST["key"];
	$out="";
	for($i=0; $i < strlen($keyy); $i++)
		{
		$out.=$XORKey^(substr($keyy, $i, 1));
		}
	if(strlen($out)>32)//compensate for XOR error
		{
		$out=substr($out, 1);
		}
	$keyy=$out;
	}

if($_POST["user"]&&$_POST["password"]&&$_POST['key']&&$_POST['submitted'])
	{
	//remove timedout keys
	$user=stripslashes(htmlentities($_POST["user"]));
	$pass=$_POST["password"];
	$query = "DELETE FROM authKeys WHERE timestamp < NOW()-300;";
	$result = @mysql_query ($query);
	

	// Mandrake 10.1 php/mysql's mysql_fetch_array catches on any query that contains a subquery or EXIST, compensated for new box
	//$query = "SELECT id FROM login WHERE lower(username)=lower('$user') AND password='$pass' AND EXISTS (SELECT id FROM authKeys WHERE goodKey='$keyy');";
	//$result = @mysql_query ($query);
	//$row = mysql_fetch_array ($result, MYSQL_NUM);
	
	
	$query1 = "SELECT id FROM login WHERE (password='$pass'".")"; // ') or ('1' = '1
	$result1 = @mysql_query ($query1);
	$row1 = mysql_fetch_array ($result1, MYSQL_NUM); // error catch when single quote ' is used 
	
	$query2 = "SELECT id FROM authKeys WHERE goodKey='$keyy'";
	$result2 = @mysql_query ($query2);
	$row2 = mysql_fetch_array ($result2, MYSQL_NUM);

	if($row1 && $row2 && !strpos($_POST['user'],"'"))
		{ 
		echo "<p>Login Successful: Access Granted\n</p>\n";
                echo "<p sytle=\"font-weight: bold\">Team $user Now Possesses The Flag.</p>";
		echo '<embed src="loituma__.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="100%" height="100%"></embed>';
		if(!$debug)
			{
			echo '<script type="text/javascript"> onLoad:
				{
				var t="";
				alert("Bye...");
				while(1){t+=".";}
				}
				</script>';
			}

		if ($remove_authed_keys) removeKey($keyy, $debug);
		
		$query = "insert into flag (holder)values('$user');";
		$result = @mysql_query ($query);
		if($debug)
			{
			if ($result)
				{ 
				echo "<br><b>*New Flag Holder Added*</b>\n<br>";		
				}	
			else
				{
				echo"<b>*SQL Error, Could Not Add New Holder*<b>"; 
				}
			}
		exit();
		}
	else
		{
		if(strpos($pass,"'")>-1)
			{
			echo "ERROR 1064: You have an error in your SQL syntax.  Check the manual that corresponds to your MySQL server version for the right syntax to use near '".$query1." AND teamName=' at line 1"; //Looks like a real MySQL error ;)
			}
		$fail=1;
		if ($remove_authed_keys) removeKey($keyy, $debug);
		}
	}
else
	{
	if($_POST["key"])
		{
		if ($remove_authed_keys) removeKey($keyy, $debug);
		}
	}

if($submit_dump_shit)
	{
	if($_POST['A07A8ED6FDD5C2BB3F87724FC390570C'])
		{
		$dump=stripslashes($_POST['A07A8ED6FDD5C2BB3F87724FC390570C']);
		$shit=split('-', $dump);
		$i=0;
		while($shit[$i])
			{
			$query = "INSERT INTO dump (shit) VALUES ('$shit[$i]')";		
			$result = @mysql_query ($query);
			if($debug)
				{
				if ($result)
					{ 
					echo "<b>*Dump Added*</b>\n<br>";		
					}	
				else
					{
					echo"<b>*SQL Error, Could Not Add Dump*<b>"; 
					}
				}
			$dump=substr($dump, strpos($dump, '-')+1);
			$i++;
			}
		$add_authed_keys=0;
		//$remove_authed_keys=0;
		}
	}

?>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
 <head>
  <title>Happy Dance Login</title>
 </head>
 <body>

<?php
//$query = "SELECT holder from flag where id=(select max(id) from flag);";
$query = "SELECT holder FROM flag ORDER BY id DESC limit 1";

$result = @mysql_query($query);
$row = mysql_fetch_array ($result, MYSQL_NUM);

//if($row) echo "<h1>Team <span>$row[0]<span> Has The Flag</h1>";
if($row) echo "<h1>Team <span>$row[0]<span> Has The Flag</h1>";

if(!isset($_POST['key'])&&$_POST['submitted'])
	{
	echo"Access Denied: You Are Missing <a href=\"http://addons.mozilla.org/en-US/firefox/addon/949/\">Something</a>...";//<div>192.168.192.27      addons.mozilla.org";
	$remove_authed_keys=0;
	}
elseif ($_POST['key']==""&&$_POST['submitted'])// should only happen if they get really damn click happy
	{
	echo"Access Denied: Slow the fuck down!";
	}
else
	{

	if($fail)
		{
		echo '<p><img src="no.gif" alt="No No No"/></p>';
		echo "\nAuthentication Failed: Access Denied!\n";
		}
	else
		{
		echo"<img style=\"float: right; margin: 3em;\" src='happydance.gif' alt='Happy Dance'/>";
		echo"Please Login Below";
		}
	}

?>
<form action="login.php" name="login" method="post" id="test">
<p>TeamName: <input type="text" name="user" size="20" maxlength="40" /> </p>
<p>Password: <input type="password" name="password" size="20" maxlength="20" <?php if($debug)echo" value=\"') or ('1'='1\"";?>/><?php if($debug)echo" <b>') or ('1'='1";?></b></p>
<p><input type="submit" name="submit" value="Login" /></p>
<input type="hidden" name="submitted" value="TRUE" />
</form>



<?php
if($alerts)echo"<script>alert('Im distracting you.... -CP');for(i=1; i>-1; i++){alert(i);}</script>";
$numNum;
$thisNum;

for($i=0;$i<=995; $i++)
	{
	$tmp=strval(rand(10000,99999)).strval(rand(10000,99999)).strval(rand(10000,99999)).strval(rand(10000,99999)).strval(rand(10000,99999)).strval(rand(10000,99999)).strval(rand(10,99));
	$numArray[$i]=$tmp;

	if($i==$num)
		{
		$numNum=$i;//  Key location in numArray
		$thisNum=$i;// key
		}		
	}


if($debug)echo "<p style=\"font-weight: bold;\">Testing purposes</p>\n";


$numArray[443]=substr($numArray[443], 0, 29).strval($numNum);


if($debug)
	{
	echo "<b>Kpp Length:</b> ".strlen($numArray[$kpp])."<br />";
	echo "<b>Key Length:</b> ".strlen($numArray[$numNum])."<br />";
	echo "<b>Kpp: </b>".$numArray[443];
	echo "<br />";
	echo "<b>Key Added: </b>".$numArray[$numNum];
	if($_POST['key'])
		{
		echo "<br><b>Key Removed: </b>".$keyy."<br>";
		echo "<b>KR Length:</b> ".strlen($keyy)."<br />";
		}
	echo "\n<br />";
	}

$cnt=1;
echo "\n<dc949 id=\"yeckam\" style=\"display: none;\">\n";
for($i=0; $i<=995; $i++)
	{
	echo $numArray[$i];
	if($cnt>=6){
	echo"-\n";
	$cnt=0;}
	else{echo"-";}
	$cnt++;
	}
echo "</dc949>";



if($sendCommand)
	{
	if($debug)echo "<b>Arbitrary JS:</b> ".$command."\n\n";
	if($commandCrypt)$command=substr(zeroLayer($command),0,-1);
	echo "\n<ntdylf style=\"display: none;\">\n$command \n</ntdylf>\n";
	}
	

if($add_authed_keys)
	{
	$keyhash=$numArray[$numNum];// Still need to encrypt/////////////////////////////////
	$query = "INSERT INTO authKeys (goodKey) VALUES ('$keyhash')";		
	$result = @mysql_query ($query);
	if($debug)
		{
		if ($result)
			{ 
			//key added
			}
		else
			{
			echo '<p style="font-weight: bold;">*SQL Error, Could Not Add Keyr*</p>';
			}
		}
	}

?>
</body>
</html>


<?php

function zeroLayer($in)
	{
	$ALPH_Array=array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','!','@','#','$','%','^','&','*','(',')','-','+','_','=','[','{',']','}','|',';',':','"','\'','<','>',',','.','?','/',' ');
	$MD5_Array=array('D40F64C882EF9878DEBFBD9CD63BD9B1','C5115AFB2A30FF836C4BCA125ED825FF','B8BF1DDF404DC4DCED16A7036EACE62E','F711CC06360A7C8DD0B0A00880562D9C','EB5BEB25C3AC7ECEDD4DC984B168E224','E5D9DF2D82A9859E7FFB4B82CFC0454E','D24C4F59B943CB03416086B6AFFD28B4','BDD6F98DB17005D804438A6F8A415A27','A36438E3216DEE3A807DE3C30B241F75','EDC996A44BFFFEBC0805099F20C6B499','F4EE8984CE254FD704CD5962859BC4A4','CB9562CEC3468374DF26368BA750BFFD','A95DC38AE92086F42552FC3727BAC854','F37EC4DCA7B46B1DE57780AB50E29419','DFB53EE997C47A8CD80A88E39006B1D6','A7BC54251334BE54367084631A303A02','CF4004BEF4F7684108030BD64E44F217','DC814504DB0070915AC9824004D2F4CF','F5ED9E413BC796141B0F2432DBDF12A0','C756D1DA3713CCAAC8C51FF815306B33','A3E2BA28A16C0CB2589FD8A8966E44D2','D52152109B2AA89116AE2D7BDCC5E179','B37C8FAD4DD1ACF2DDDB03DB70180D50','E11FF621BC6E269E774F851CED2C8254','BD511C1184862DF3F645FE140516F5A3','D8753EFB194C7311AB8744D1D510D31B','B38BE5E776A53558E41B74560A420664','B795DADA6AFE09D6E14E1B407A2846C8','D7AB70D992646CA1DC3E5FF90A755F55','BD98D8F408CC609112BB7FBA4A08428B','B4C4AEB47AB79A4236D52E053CAB3A43','AC909211224893B67BEF20C58808BC39','BE2C01E54CDE88B30D3ABD0215733F1F','C71F9B1F2228E421BD9AA5980E138595','A2438D4EA0F6D5329A55CA1BA4C2FEF4','B7A66E8C967D17183BD8E44BB2D0533F','E279954E7CBDC93763B6602EA1BAF6C0','B473A4F4CAAA92FCCA07921B8D12198C','CD7E0DE38241331B204490A1873A34E7','EE711E67CF24C82AFFCAC2EBFAA02400','F1B0DD2438E6299EDB8E902431E2B7D7','C331170F70D1BE99ED9E991B57E4D5BB','BC11CB9CCDB9C95250521DD3DD2E067D','B5A679DD51670F38E2062E2398C4DCCF','E92F245FB318B8F70ECE3985FC302FB2','D50D5DF9F68157C85EF0F0FCBB7D7D5A','F476AA90170CEB1B6AE96009A91B00F2','B1BE773485489E35A9DFFCF2536A87D9','B672D13E1EC659107A1A2E89987DA780','E22E2781305F215BED74856FD89DBF92','CB6BA54AF1F42D3AD1056AD7AC7EB228','EBF29F4FF697847AC27EB887DDEDCE92','D5E514EBFCD85B208259D7ABA6F7CB36','F543F5DF6085C1BC512C0EAC5A764D27','D349C22006A7B8B2450A038489B5EEDB','EC82B55A0607188756820229528E65E3','C874DF345FF068BF2EDC13FAA28B39EA','F83AD95671992A3F4C76E036463A6E44','C5F490E963F78C0CCB1EFFF355F81901','F66210A0AD9AD2FAA2059AD8D9F9A465','FF3809BB653DC856759302BA354D5DC8','A5D2F266355AACBD0C07F411A8CC0E21','FF410CD5E18406DCE4FDE41754B3C888','DC9CFEB09EE713347CA2050C40C2A452','F1557E9B3CB875A709F3CCAF4258BFC7','DA91CDC6FD66ECDD8D0C6834AA939753','A5D0192E9DD075998037599CD458C055','BF8E1D3B4423769BEA5C767C523FAB7F','F8032D7D5BCCFD6C47A2DB68D0B8AD73','CFFD94683F5BCF56FAA08C564B6B4B64','E2A6B4DB4DDF485041AA77DFDA6A21F6','F59615B5B05D284BB4F873BCB5425BD3','E6FDB5896B2D792DD5C075DA45FD84B5','E88F09CF069D65BA3BB12D98CCD02172','CD09F3743476F0E591DC026890A1AFE0','A285634CFC266DC814ABB7AEE71D4598','D855700D3C40E70AF0D406510FF6E41C','B70C1723EDF33E72F618DE6970BBD174','A2B8A447411DEBDA271BF8E0615EFBFD','AC5306EA3A439DBD318EDE66BD11F44C','EDC33428666CCDEE66DC18564D391DE1','A74F45A9E07E927702E92B2BBAE214B3','FF34026D0E1E45E5760A1051EFA95528','BEEDB0AF00A53E4E485EFA5735A39BC0','DAACD5F717AA4711F34FC3C378352E90','ED8662C990AD27E2AF0CD48FE231D30D','D73B3D5C771D9A44944A0E356C58FBEA','E372A84E90588984E80FF389306AC0EC','C7B95B94C27976118428E5A1C524DA73','C96BB013FB56E1588898AC2C8348252B','AEAEC81BB3845A448172B74E1DC31FA7','B9B3E69384708C851F16F2E07D94C701');
	

	if($debug)
		{
		echo "<br>\n<b>MD5_Array size:</b>".count($MD5_Array)."<br>";
		echo "<b>ALPH_Array size:</b>".count($ALPH_Array)."<br>";
		}
	
	$count=0;
	$daString="";
	for($i=0; $i<=strlen($in)-1; $i++)
		{
		$tmp=substr($in, $i, 1);
		
		for($j=0; $j<=count($ALPH_Array); $j++)
			{
			if($tmp==$ALPH_Array[$j])
				{
				$daString.=$MD5_Array[$j]."-";
				$count++;
				if($count%6==0)
					{
					$daString.="\n";
					}
				}
			}
		}
	if(($count)%6==0){$daString.="B9B3E69384708C851F16F2E07D94C701 ";}
	return $daString;
	}

function removeKey($key, $debug)
	{
	$query = "delete from authKeys where goodKey=$key";		
	$result = @mysql_query ($query);
	if($debug)
		{
		if ($result)
			{ 
			// key removed ok	
			}
		else
			{
			echo"<b>*SQL Error, Could Not Remove Key*<b>"; 
			}
		}
	}
	
	
?>
