<?php

if(!function_exists("mysql_connect"))echo "fail";


DEFINE ('DB_USER', 'shoe');
DEFINE ('DB_PASSWORD', 'myTable');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'happydance');

$dbc = @mysql_connect (DB_HOST, DB_USER, DB_PASSWORD) OR die ('Could not connect to MySQL: ' . mysql_error() );

$dbc = @mysql_connect (DB_HOST, DB_USER, DB_PASSWORD) OR die ('Could not connect to MySQL: ' . mysql_error() );
@mysql_select_db (DB_NAME) OR die ('Could not select the database: ' . mysql_error() );


function escape_data ($data)
	{
	if (ini_get('magic_quotes_gpc'))
		{
		$data = stripslashes($data);
		}
	if (function_exists('mysql_real_escape_string'))
		{
		global $dbc;
		$data = mysql_real_escape_string (trim($data), $dbc);
		}
	else
		{
		$data = mysql_escape_string (trim($data));
		}	
	return $data;
	}
?>
