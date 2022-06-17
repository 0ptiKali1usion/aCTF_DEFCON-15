<?php
// Make sure we have built in support for MySQL
if (!function_exists('mysql_connect'))
  exit('This PHP environment doesn\'t have MySQL support built in. MySQL support is required if you want to use a MySQL database to run this program. Consult the PHP documentation for further assistance.');

function error($errorMsg) {
  exit($errorMsg);
}
  
class DBLayer
{
  var $link_id;
  var $query_result;
  var $row = array();
  var $num_queries = 0;


  function DBLayer($db_host, $db_username, $db_password, $db_name, $p_connect)
  {
    if ($p_connect)
      $this->link_id = @mysql_pconnect($db_host, $db_username, $db_password);
    else
      $this->link_id = @mysql_connect($db_host, $db_username, $db_password);
    if ($this->link_id)
    {
      if (@mysql_select_db($db_name, $this->link_id))
        return $this->link_id;
      else
        error('Unable to select database. '.mysql_error(), __LINE__, __FILE__);
    }
    else
      error('Unable to connect to MySQL server. '.mysql_error(), __LINE__, __FILE__);
  }

  function query($sql = '', $transaction = 0)
  {
    unset($this->query_result);
    if ($sql != '')
      $this->query_result = @mysql_query($sql, $this->link_id);
    if ($this->query_result)
    {
      $this->num_queries++;
      unset($this->row[$this->query_result]);
      return $this->query_result;
    }
    else
      return ($transaction == PUN_TRANS_END) ? true : false;
  }

  function result($query_id = 0, $row = 0)
  {
    if (!$query_id)
      $query_id = $this->query_result;
    return ($query_id) ? @mysql_result($query_id, $row) : false;
  }

 function fetch_array($query_id = 0)
  {
    if (!$query_id)
      $query_id = $this->query_result;
    if ($query_id)
    {
      $this->row[$query_id] = @mysql_fetch_array($query_id);
      return $this->row[$query_id];
    }
    else
      return false;
  }

  function fetch_assoc($query_id = 0)
  {
    if (!$query_id)
      $query_id = $this->query_result;
    if ($query_id)
    {
      $this->row[$query_id] = @mysql_fetch_assoc($query_id);
      return $this->row[$query_id];
    }
    else
      return false;
  }

 function fetch_row($query_id = 0)
  {
    if (!$query_id)
      $query_id = $this->query_result;
    if ($query_id)
    {
      $this->row[$query_id] = @mysql_fetch_row($query_id);
      return $this->row[$query_id];
    }
    else
      return false;
  }

  function num_rows($query_id = 0)
  {
    if (!$query_id)
      $query_id = $this->query_result;
    return ($query_id) ? @mysql_num_rows($query_id) : false;
  }

  function affected_rows()
  {
    return ($this->link_id) ? @mysql_affected_rows($this->link_id) : false;
  }

  function insert_id()
  {
    return ($this->link_id) ? @mysql_insert_id($this->link_id) : false;
  }

  function get_num_queries()
  {
    return $this->num_queries;
  }

  function free_result($query_id = false)
  {
    if (!$query_id )
      $query_id = $this->query_result;
    return ($query_id) ? @mysql_free_result($query_id) : false;
  }

  function error()
  {
    $result['error'] = @mysql_error($this->link_id);
    $result['errno'] = @mysql_errno($this->link_id);
    return $result;
  }

  function close()
  {
    if ($this->link_id)
    {
      if ($this->query_result)
        @mysql_free_result($this->query_result);
      return @mysql_close($this->link_id);
    }
    else
      return false;
  }

  // go to row number $row (range from 0 to mysql_num_rows - 1)
  function data_seek($row, $query_id = false)
  {
    if (!$query_id )
      $query_id = $this->query_result;
    return mysql_data_seek($query_id, $row);
  }
};

// create a new database object
$db = new DBLayer('localhost', 'testuser', "testpass", 'test', false);
