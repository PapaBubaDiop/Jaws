<?php
include($_SERVER['DOCUMENT_ROOT'].'/iphone.php');
include($db_path);
if (isset( $host) && isset( $db_user) && isset($db_pass) && isset($db_sql))
$link = mysql_connect($host, $db_user, $db_pass) or die("<B><I>Can't connect to MySQL database".' '.mysql_error()."</I>");
mysql_select_db($db_sql);
$code_sql = "SET NAMES utf8";
$code_res = mysql_query($code_sql);


if (isset($_GET['udid'])) $imea=($_GET['udid']); else $imea="imea";
    

echo '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="minimum-scale=1.0, width=320, maximum-scale=0.6667, user-scalable=no" name="viewport" />
<link href="jaws.css" rel="stylesheet" media="screen" type="text/css" />
<title>jaws Top Charts</title>
</head>
<body >
';
 
    
    
    $iplace = 0;
    
    
    echo '<div id="content">';
    echo '<span class="graytitle">Today Top Best</span><ul class="pageitem">';
    
    
    
    $result = mysql_query("SELECT * FROM jaws_users ORDER BY points DESC LIMIT 25 ");
    while ($row = mysql_fetch_array($result)) {
        $na=$row['name'];
        $ip=$row['ip'];
        $im=$row['imea'];
        $bt=$row['points'];
        
        if ($im==$imea) {
            $iplace = 1;
            echo'<li class="store">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        } else {
            echo'<li class="store2">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        }
    }
    
    if ($iplace==0) {
        $result = mysql_query("SELECT * FROM jaws_users WHERE imea='$imea' LIMIT 1");
        if ($row = mysql_fetch_array($result)) {
            $na=$row['name'];
            $ip=$row['ip'];
            $im=$row['imea'];
            $bt=$row['points'];
            echo'<li class="store">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        }
    }
    
    echo '</ul><br/>';
    echo '</div>';
    
    
    $iplace = 0;
    
    
    echo '<div id="content">';
    echo '<span class="graytitle">Total Game Played</span><ul class="pageitem">';
    
    $result = mysql_query("SELECT * FROM jaws_users ORDER BY games DESC LIMIT 25 ");
    while ($row = mysql_fetch_array($result)) {
        $na=$row['name'];
        $ip=$row['ip'];
        $im=$row['imea'];
        $bt=$row['games'];
        
        if ($im==$imea) {
            $iplace = 1;
            echo'<li class="store">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        } else {
            echo'<li class="store2">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        }
    }
    
    if ($iplace==0) {
        $result = mysql_query("SELECT * FROM jaws_users WHERE imea='$imea' LIMIT 1");
        if ($row = mysql_fetch_array($result)) {
            $na=$row['name'];
            $ip=$row['ip'];
            $im=$row['imea'];
            $bt=$row['games'];
            echo'<li class="store">
            <span class="number"><img id="fl_'.strtolower($ip).'" src="'.$img_path.'flags/'.strtolower($ip).'.png" width="24"  /></span>
            <span class="name">'.$na.'</span>
            <span class="clicks">'.$bt.'</span>
            </li>';
        }
    }
    
    echo '</ul><br/>';
    echo '</div>';
    
    
    echo '<br><br>Добродошли в Крагуевац jaws<br>';
    
    
echo '</body>';

?>


