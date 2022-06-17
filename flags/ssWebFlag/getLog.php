<?php
  $filename = $_POST['filename'];
  $logDir = "C:\\wamp\\Apache2\\logs\\";
  $logDir = "/usr/local/apache2/logs/";
  
  $fp = fopen($logDir . $filename, "r");
  if($fp) {
    $logContents = fread($fp, filesize($logDir . $filename));
    echo $logContents;
  } else {
    echo "Unable to open " . $logDir . $filename;
  }
?>
