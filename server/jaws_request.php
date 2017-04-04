<?php
include($_SERVER['DOCUMENT_ROOT'].'/iphone.php');
include($db_path);
if (isset( $host) && isset( $db_user) && isset($db_pass) && isset($db_sql))
$link = mysql_connect($host, $db_user, $db_pass) or die("<B><I>Can't connect to MySQL database".' '.mysql_error()."</I>");
mysql_select_db($db_sql);
$code_sql = "SET NAMES utf8";
$code_res = mysql_query($code_sql);

$today = date("Y-m-d");
$totime = date("H:i");




    if (isset($_GET['points'])) $points=($_GET['points']) + 0; else $points=0;
    if (isset($_GET['games'])) $games=($_GET['games']) + 0; else $games=0;
    
    if (isset($_GET['udid'])) $imea=$_GET['udid']; else $imea=0;
    if (isset($_GET['name'])) $name=($_GET['name']); else $name=0;

    
    
$ipAddress = $_SERVER['REMOTE_ADDR']; 

$xml = file_get_contents('http://api.wipmania.com/' . $ipAddress . '?k=E2g-Y6pynerVPDAIKuOcWQrmGQ3');
$ipCode = $xml;


    if (strlen($ipCode)<2) $ipCode = 'XX';
    $ipcountryCode = $ipCode.'('.$ipAddress.')';
    
 // get stats
    $n = mysql_escape_string($name);
    $uid=0;
    
    $sql_temp = "INSERT INTO jaws_users (name, imea, ip) VALUES ('$n', '$imea', '$ipCode') ON DUPLICATE KEY UPDATE name='$n' ";
//    echo $sql_temp.'<br>';
    mysql_query($sql_temp);
    $result = mysql_query("SELECT * FROM jaws_users WHERE imea='$imea' LIMIT 1");
    if ($row = mysql_fetch_array( $result )) {
        $uid=$row['uid'];
        $t_games=$row['games'];
        $t_points=$row['points'];
        $t_best=$row['best'];
        
        
        
        if ($games>$t_games) $t_games = $games;
        if ($points>$t_points) $t_points = $points;
        if ($points>$t_best) $t_best = $points;
        

        mysql_query("UPDATE jaws_users SET name='$n', ip='$ipCode', points='$t_points', games='$t_games', best='$t_best' WHERE uid='$uid' ");
    }

    $total = 0;
    $rank = 0;
    $best = 0;
    
    $result = mysql_query("SELECT * FROM jaws_users ORDER BY points DESC LIMIT 1");
    if ($row = mysql_fetch_array($result)) {
        $best=$row['points'];
    }
    
    $result = mysql_query("SELECT COUNT(*) as total FROM jaws_users");
    if ($row = mysql_fetch_array($result)) {
        $total=$row['total'];
    }
 
    $result = mysql_query("SELECT COUNT(*) as rank FROM jaws_users WHERE points>'$points' ");
    if ($row = mysql_fetch_array($result)) {
        $rank=$row['rank'] + 1;
    }
    
    echo $total.'<br>';
    echo $rank.'<br>';
    echo $best.'<br>';
    echo '<br>';
    echo '<br>';
    
    mysql_close($link);


?>


