<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
    include "/home/GGDPS0001/public_html/sdloader/modfs/action/dblib.php";
    function UrlParameter($targ){
        return filter_input(INPUT_GET, $targ, FILTER_SANITIZE_URL);
    }
    // dont check for action cause thats always existing
    $action = UrlParameter("action");
	//
	$id = "1";
	if (!empty(UrlParameter("uniq_id"))) {
		$id = UrlParameter("uniq_id");
	}
	//
	$name = "Player";
	if (!empty(UrlParameter("name"))) {
		$name = UrlParameter("name");
	}
	//
	$logo = "";
	if (!empty(UrlParameter("logo"))) {
		$logo = UrlParameter("logo");
	}
	//
	$cid = "";
	if (!empty(UrlParameter("id_clan"))) {
		$cid = UrlParameter("id_clan");
	}
	//
	$param = "";
	if (!empty(UrlParameter("param"))) {
		$param = UrlParameter("param");
	}
	//
	$platform = "";
	if (!empty(UrlParameter("platform"))) {
		$platform = UrlParameter("platform");
	}
	//
	$token = "";
	if (!empty(UrlParameter("token"))) {
		$token = UrlParameter("token");
	}
	//
	$appver = "";
	if (!empty(UrlParameter("app_version"))) {
		$appver = UrlParameter("app_version");
	}
	//
	$yourip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	echo $action . "\n";
    switch ($action) {
        case "start_check":
            $tokenget = $db->prepare("SELECT clan FROM `pgx_users` WHERE id = :name");
            $tokenget->bindparam(":name", $id);
            $tokenget->execute();
            $token = $tokenget->fetchColumn();
            if (strval($token) == "0"){
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
                $tokenget->bindparam(":name", $token);
                $tokenget->execute();
                $cid = $tokenget->fetchColumn();
                $tokenget = $db->prepare("SELECT name FROM `pgx_clans` WHERE id = :name");
                $tokenget->bindparam(":name", $token);
                $tokenget->execute();
                $nm = $tokenget->fetchColumn();
                $tokenget = $db->prepare("SELECT logo FROM `pgx_clans` WHERE id = :name");
                $tokenget->bindparam(":name", $token);
                $tokenget->execute();
                $log = $tokenget->fetchColumn();
                echo '{"id":"' . $token . '","creator_id":"'.$cid.'","name":"'.$nm.'","logo":"'.$log.'"}"';
            }
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
                echo "{\"info\":{\"creator_id\":\"{$creatorID}\",\"name\":{$clanName},\"logo\":{$clanLogo}},\"players\":{\"0\":1},\"invites\":{\"0\":1}}";
            }
            break;
		case "create_clan":
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, :id, :name, :logo, :id, '10.3.0');");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":name", $name);
			$tokenget->bindparam(":logo", $logo);
            $tokenget->execute();
			$response = $db->lastInsertId();
			$tokenget = $db->prepare("UPDATE `pgx_users` SET `clan`=:clan WHERE id = :id");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":clan", $response);
            $tokenget->execute();
			echo $response;
			break;
		case "create_player_intent":
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			if (!empty($token)) {
				$tokenget = $db->prepare("INSERT INTO `pgx_users` (`id`, `platform`, `token`, `clan`, `username`) VALUES (NULL, :platform, :token, 0, 'Player');");
				$tokenget->bindparam(":platform", $platform);
				$tokenget->bindparam(":token", $token);
				$tokenget->execute();
				$response = $db->lastInsertId();
				// echo $response;
				echo "fail";
			}else {
				echo md5($appver . $yourip);
			}
			break;
		case "change_logo":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `logo`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $logo);
            $tokenget->execute();
			echo $response;
			break;
		case "change_clan_name":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `name`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $name);
            $tokenget->execute();
			echo $response;
			break;
		case "friend_request":
			// NOT IFNIHED
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `name`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $cid);
			$tokenget->bindparam(":logo", $logo);
            $tokenget->execute();
			echo $response;
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