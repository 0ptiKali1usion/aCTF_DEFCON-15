<?

require_once ('mysql_connect.php');
$query = "SELECT holder from flag order by id desc limit 1";
$result = @mysql_query ($query);
$row = mysql_fetch_array ($result, MYSQL_NUM);
if($row) echo "<span>$row[0]</span>\n";

?>