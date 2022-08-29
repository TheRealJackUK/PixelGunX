<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
    include "/home/GGDPS0001/public_html/sdloader/modfs/action/dblib.php";
    // dont check for action cause thats always existing
    $action = $_POST["action"];
	//
	$id = "1";
	if (isset($_POST["uniq_id"])) {
		$id = $_POST["uniq_id"];
	}
	//
	$name = "Player";
	if (isset($_POST["name"])) {
		$name = $_POST["name"];
	}
	//
	$nick = "Player";
	if (isset($_POST["nick"])) {
		$nick = $_POST["nick"];
	}
	//
	$skin = "skin";
	if (isset($_POST["skin"])) {
		$skin = $_POST["skin"];
	}
	//
	$logo = "";
	if (isset($_POST["logo"])) {
		$logo = $_POST["logo"];
	}
	//
	$cid = "";
	if (isset($_POST["id_clan"])) {
		$cid = $_POST["id_clan"];
	}
	//
	$param = "";
	if (isset($_POST["param"])) {
		$param = $_POST["param"];
	}
	//
	$platform = "";
	if (isset($_POST["platform"])) {
		$platform = $_POST["platform"];
	}
	//
	$token = "";
	if (isset($_POST["token"])) {
		$token = $_POST["token"];
	}
	//
	$appver = "";
	if (isset($_POST["app_version"])) {
		$appver = $_POST["app_version"];
	}
	//
	$yourip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	$deviceid = "";
	if (isset($_POST["deviceid"])) {
		$deviceid = $_POST["deviceid"];
	}
    switch ($action) {
        case "start_check":
        	$usesrget = $db->prepare("SELECT id FROM `pgx_users` WHERE id = :name");
            $usesrget->bindparam(":name", $id);
            $usesrget->execute();
            $usesrgetresult = $usesrget->fetchColumn();
            if (strcmp(trim(strval($usesrgetresult)), trim(strval($id))) !== 0) {
				echo 'fail';
				break;
			}
            $tokenget = $db->prepare("SELECT clan FROM `pgx_users` WHERE id = :name");
            $tokenget->bindparam(":name", $id);
            $tokenget->execute();
            $tooken = $tokenget->fetchColumn();
            if (strval($tooken) == "0"){
                $tokenget = $db->prepare("SELECT username FROM `pgx_users` WHERE id = :name");
                $tokenget->bindparam(":name", $id);
                $tokenget->execute();
                $namecheck = $tokenget->fetchColumn();
                if (empty($namecheck)){
                    echo 'fail';
                }else{
                    echo $id;
                }
            }else{
                // {"id":0,"creator_id":0,"name":"example","logo":"png here"}
                $tokenget = $db->prepare("SELECT pid FROM `pgx_clans` WHERE id = :name");
                $tokenget->bindparam(":name", $tooken);
                $tokenget->execute();
                $cid = $tokenget->fetchColumn();
                $tokenget = $db->prepare("SELECT name FROM `pgx_clans` WHERE id = :name");
                $tokenget->bindparam(":name", $tooken);
                $tokenget->execute();
                $nm = $tokenget->fetchColumn();
                $tokenget = $db->prepare("SELECT logo FROM `pgx_clans` WHERE id = :name");
                $tokenget->bindparam(":name", $tooken);
                $tokenget->execute();
                $log = $tokenget->fetchColumn();
                echo '{"id":"' . $token . '","creator_id":"'.$cid.'","name":"'.$nm.'","logo":"'.$log.'"}"';
            }
            break;
        case "user_exists":
        	$usesrget = $db->prepare("SELECT id FROM `pgx_users` WHERE id = :name");
            $usesrget->bindparam(":name", $id);
            $usesrget->execute();
            $usesrgetresult = $tokenget->fetchColumn();
            if (strcmp(trim(strval($usesrgetresult)), trim(strval($id))) !== 0) {
				echo 'fail';
				break;
			}
			echo $id;
            break;
        case "get_clan_info":
            $tokenget = $db->prepare("SELECT clan FROM `pgx_users` WHERE id = :name");
            $tokenget->bindparam(":name", $id);
            $tokenget->execute();
            $token = $tokenget->fetchColumn();
            if (strval($token) == "0"){
                echo "";
            }else{
                // GetDBVarOne
                // {"info":{"creator_id":0,"name":"example","logo":"png here"},"players":{"0":1},"invites":{"0":1}}
                $creatorID = GetDBVarOne("pgx_clans", "pid", "WHERE id = :name", [":name" => $token]);
                $clanName = GetDBVarOne("pgx_clans", "name", "WHERE id = :name", [":name" => $token]);
                $clanLogo = GetDBVarOne("pgx_clans", "logo", "WHERE id = :name", [":name" => $token]);
                // temporary fix
                echo "{\"info\":{\"creator_id\":\"". $creatorID ."\",\"name\":" . $clanName . ",\"logo\":" . $clanLogo . "},\"players\":{\"0\":" . $creatorID . "},\"invites\":{\"0\":1}}";
            }
            break;
		case "create_clan":
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `originver`) VALUES (NULL, :id, :name, :logo, :appver);");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":name", $name);
			$tokenget->bindparam(":logo", $logo);
			$tokenget->bindparam(":appver", $appver);
            $tokenget->execute();
			$response = $db->lastInsertId();
			$tokenget = $db->prepare("UPDATE `pgx_users` SET `clan`=:clan WHERE id = :id");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":clan", $response);
            $tokenget->execute();
			echo $response;
			break;
		case "create_player":
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("INSERT INTO `pgx_users` (`id`, `platform`, `token`, `clan`, `username`, `ip`, `did`) VALUES (NULL, :platform, :token, 0, 'Player', :ip, :deviceid);");
			$tokenget->bindparam(":platform", $platform);
			$tokenget->bindparam(":token", $token);
			$finalip = md5($yourip);
			$tokenget->bindparam(":ip", $finalip);
			// deviceid
			$tokenget->bindparam(":deviceid", $deviceid);
			$tokenget->execute();
			$response = $db->lastInsertId();
			echo $response;
			// echo "fail";
			break;
		case "create_player_intent":
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			echo md5($appver . $deviceid);
			break;
		case "change_logo":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `logo`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $logo);
            $tokenget->execute();
			echo 1;
			break;
		case "update_player":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_users` SET `username`=:nick, `skin`=:skin WHERE id = :id");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":nick", $nick);
			$tokenget->bindparam(":skin", $skin);
            $tokenget->execute();
			echo 1;
			break;
		case "change_clan_name":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `name`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $name);
            $tokenget->execute();
			echo 1;
			break;
		case "friend_request":
			// NOT IFNIHED
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			/*$tokenget = $db->prepare("UPDATE `pgx_clans` SET `name`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $logo);
            $tokenget->execute();
			echo $response;*/
			break;
		case "get_users_info_by_param":
			$qeryname = htmlspecialchars($param, ENT_QUOTES);
			$qeryname = trim($qeryname);
			if (is_numeric($qeryname)){
				$usersget = $db->prepare("SELECT id, username FROM `pgx_users` WHERE id LIKE '%" . $qeryname . "%'");
				$usersget->execute();
				$users = $usersget->fetchAll();
				$fullreturnstring = "[";
				foreach($users as &$user) {
					$fullreturnstring .= "{\"id\": \"{$user["id"]}\"},";
				}
				$fullreturnstring .= "]";
				echo $fullreturnstring;
			}else{
				$usersget = $db->prepare("SELECT id, username FROM `pgx_users` WHERE username LIKE '%" . $qeryname . "%'");
				$usersget->execute();
				$users = $usersget->fetchAll();
				$fullreturnstring = "[";
				foreach($users as &$user) {
					$fullreturnstring .= "{\"id\": \"{$user["id"]}\", \"nick\": \"{$user["username"]}\",\"rank\":\"30\",\"skin\":\"a\"},";
				}
				$fullreturnstring .= "]";
				echo $fullreturnstring;
			}
			break;
    }
?>