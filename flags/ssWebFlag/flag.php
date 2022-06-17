<?php
  // don't break shit!
  $flag = "flag.txt";
  $fp = fopen($flag, "r");
  if($fp) {
    echo fread($fp, filesize($flag));
  }
?>