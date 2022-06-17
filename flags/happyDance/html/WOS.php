<b><p>Wall of shame</p></b>
<style>
table{
border: 1px solid black;
border-collapse: collapse;
margin 0px;}
td{
border: 1px solid black;
border-collapse: collapse;}
</style>
<?php
// make each feild itws own shit
require_once ('mysql_connect.php');
$query = "SELECT shit from dump;";
$result = @mysql_query ($query);
echo"<table>
<tr><b><td>Hostname</td><td>Username</td><td>Password</td></b></tr>";
while($row = mysql_fetch_array ($result, MYSQL_NUM))
	{
	$tmp=split(":", $row[0]);
 	echo "<tr><td>" . $tmp[0] . "</td><td>" . $tmp[1] . "</td><td>" . $tmp[2] . "</td></tr>";
	}
	
echo "</table>";




?>