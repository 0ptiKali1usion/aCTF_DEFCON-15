<?php
  include "mysql.php";
  if(isset($_POST['user']) && $_POST['user'] != "") {
    // username and password of ' or '1'='1 makes for a nice injection :-)
    $query = "SELECT username FROM user WHERE username = '" . $_POST['user'] .
	         "' AND password = '" . $_POST['pass'] . "'";
    $db->query($query);
	if($db->num_rows() != 1) {
      echo $query;
	  error("Login failed.  Invalid username / password");
	}
  } else {
    header("Location: index.php");
  }
?>
<html>
 <body>
  <h1>Login successful</h1>
  <!-- Removed June 30, 2007
  if($_GET['admin'] == "1")
    include "admin.php";
  -->
  Admin panel is currently disabled.
 </body>
</html>
