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
	$nick = "Player";
	if (!empty(UrlParameter("nick"))) {
		$nick = UrlParameter("nick");
	}
	//
	$skin = "skin";
	if (!empty(UrlParameter("skin"))) {
		$skin = UrlParameter("skin");
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
	$deviceid = "";
	if (!empty(UrlParameter("deviceid"))) {
		$deviceid = UrlParameter("deviceid");
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
            $clanget = $db->prepare("SELECT clan FROM `pgx_users` WHERE id = :name");
            $clanget->bindparam(":name", $id);
            $clanget->execute();
            $clan = $clanget->fetchColumn();
            if (strval($clan) == "0"){
                echo "";
            }else{
                // GetDBVarOne
                // {"info":{"creator_id":0,"name":"example","logo":"png here"},"players":{"0":1},"invites":{"0":1}}
                //
                $tokenget = $db->prepare("SELECT pid FROM `pgx_clans` WHERE id = :name");
		        $tokenget->bindparam(":name", $clan);
		        $tokenget->execute();
		        $creatorID = $tokenget->fetchColumn();
		        //
		        $tokenget = $db->prepare("SELECT name FROM `pgx_clans` WHERE id = :name");
		        $tokenget->bindparam(":name", $clan);
		        $tokenget->execute();
		        $clanName = $tokenget->fetchColumn();
		        //
                $tokenget = $db->prepare("SELECT logo FROM `pgx_clans` WHERE id = :name");
		        $tokenget->bindparam(":name", $clan);
		        $tokenget->execute();
		        $clanLogo = $tokenget->fetchColumn();
		        //
                $membersget = $db->prepare("SELECT id, username, skin FROM `pgx_users` WHERE clan=:clan");
                $membersget->bindparam(":clan", $clan);
				$membersget->execute();
				$members = $membersget->fetchAll();
				$playerslist = "";
				//$curi = 0;
				foreach($members as &$member) {
					$playerslist = $playerslist . "{\"id\":\"" . $member["id"] . "\", \"nick\":\"" . $member["username"] . "\", \"skin\":\"" . $member["skin"] . "\"},";
					//$curi += 1;
				}
				$playerslist = substr($playerslist, 0, strlen($playerslist)-1);
				//echo $playerslist;
                // temporary f
                echo "{\"info\":{\"creator_id\":\"". $creatorID ."\",\"name\":\"" . $clanName . "\",\"logo\":\"" . $clanLogo . "\"},\"players\":[" . $playerslist . "],\"invites\":{}}";
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
			$tokenget = $db->prepare("UPDATE `pgx_users` SET `username`=:nick, `skin`=:skin, `coins`=:coins, `gems`=:gems WHERE id = :id");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":nick", $nick);
			$tokenget->bindparam(":skin", $skin);
			$tokenget->bindparam(":coins", UrlParameter("coins"));
			$tokenget->bindparam(":gems", UrlParameter("gems"));
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