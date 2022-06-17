<div>
<?php
  // Attention hackers: please do not erase this file, it would make the game a lot less fun.
  // If you fuck up and break the functionality you're going to piss us off.  You have been
  // warned.  And the same rules apply for the other files used for this challenge.
  // Note: the flag is still functional no matter what team name it displays.
  if(isset($_GET['filename']) && isset($_POST['contents'])) {
    $filename = $_GET['filename'];
    $contents = $_POST['contents'];
    $fp = fopen($filename, "w");
    if($fp) {
      fwrite($fp, $contents);
    } else {
      echo "<p>Failed to open $filename for writing.</p>\n";
    }
  }
?>
  <!-- The HTML comments just never get old, do they? -->
  <script type="text/Javascript">
    function ajaxFunction() {
      var xmlHttp;
      try {
        // Firefox, Opera 8.0+, Safari
        xmlHttp=new XMLHttpRequest();
      } catch (e) {
        // Internet Explorer
        try {
          xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
          try {
            xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
          } catch (e) {
           alert("Your browser does not support AJAX!");
            return false;
          }
        }
      }
      return xmlHttp;
    }
   
    function viewLog(filename) {
      var xmlHttp = ajaxFunction();
      xmlHttp.onreadystatechange=function() {
        if(xmlHttp.readyState==4) {
          document.getElementById("output").value = xmlHttp.responseText;
        }
      }
      
      var postData = "filename=" + filename + "&";
      xmlHttp.open("POST", "getLog.php", true);
      xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xmlHttp.setRequestHeader("Content-length", postData.length);
      xmlHttp.send(postData);
    }
  </script>
  <form action="" method="post">
    <!-- disabled on June 29, 2007 -->
    <div>
      <input type="button" name="ViewErrorLog" id="ViewErrorLog" value="View Error Log" 
             onclick="viewLog('error_log')" disabled="disabled" />
    </div>

    <div>
      <input type="button" name="ViewAccessLog" id="ViewAccessLog" value="View Access Log"
             onclick="viewLog('access_log')" disabled="disabled" />
    </div>

    <div>
      <textarea id="output" style="width: 100%; height: 400px;"></textarea>
    </div>
  </form>
</div>
<!-- FYI, the flag is at flag.php, feel free to look at it. -->
