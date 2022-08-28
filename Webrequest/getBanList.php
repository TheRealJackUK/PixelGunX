<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
    include "/home/GGDPS0001/public_html/sdloader/modfs/action/dblib.php";
	$yourip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	$deviceid = "";
	if (isset($_POST["device_identifier"])) {
		$deviceid = $_POST["device_identifier"];
	}
	// test ip
    $usesrget = $db->prepare("SELECT banvalue FROM `pgx_bans` WHERE banvalue = :name");
    $usesrget->bindparam(":name", $yourip);
    $usesrget->execute();
    $usesrgetresult = $tokenget->fetchColumn();
    if (strcmp(trim(strval($usesrgetresult)), trim(strval($yourip))) !== 0) {
		echo 0;
		return;
	}else{
		echo 1;
		return;
	}
	// test device id
    $usesrget = $db->prepare("SELECT banvalue FROM `pgx_bans` WHERE banvalue = :name");
    $usesrget->bindparam(":name", $deviceid);
    $usesrget->execute();
    $usesrgetresult = $tokenget->fetchColumn();
    if (strcmp(trim(strval($usesrgetresult)), trim(strval($deviceid))) !== 0) {
		echo 0;
		return;
	}else{
		echo 1;
		return;
	}
?>