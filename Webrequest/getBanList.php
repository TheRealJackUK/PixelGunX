<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
    include "/home/GGDPS0001/public_html/sdloader/modfs/action/dblib.php";
	$yourip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	$deviceid = "";
	if (isset($_POST["device_identifier"])) {
		$deviceid = $_POST["device_identifier"];
	}
	// test ip
	$finalip = md5($yourip);
    $usesrget = $db->prepare("SELECT banvalue FROM `pgx_bans` WHERE banvalue = :name");
    $usesrget->bindparam(":name", $finalip);
    $usesrget->execute();
    $usesrgetresult = $usesrget->fetchColumn();
    if (strcmp(trim(strval($usesrgetresult)), trim(strval($finalip))) == 0) {
		echo 1;
	}else{
		echo 0;
	}
	// test device id
    $usesrget = $db->prepare("SELECT banvalue FROM `pgx_bans` WHERE banvalue = :name");
    $usesrget->bindparam(":name", $deviceid);
    $usesrget->execute();
    $usesrgetresult = $usesrget->fetchColumn();
    if (strcmp(trim(strval($usesrgetresult)), trim(strval($deviceid))) == 0) {
		echo 1;
	}else{
		echo 0;
	}
?>