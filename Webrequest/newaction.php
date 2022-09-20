<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
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
            if ($tooken == 0){
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
                echo '{"id":"' . $tooken . '","creator_id":"'.$cid.'","name":"'.$nm.'","logo":"'.$log.'"}"';
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
            $clanget->bindparam(":name", $_POST["id_player"]);
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
					$playerslist .= "{\"id\":\"" . $member["id"] . "\", \"nick\":\"" . $member["username"] . "\", \"skin\":\"" . $member["skin"] . "\"},";
					//$curi += 1;
				}
				$playerslist = substr($playerslist, 0, strlen($playerslist)-1);
                // temporary f
                echo "{\"info\":{\"creator_id\":\"". $creatorID ."\",\"name\":\"" . $clanName . "\",\"logo\":\"" . $clanLogo . "\"},\"players\":[" . $playerslist . "],\"invites\":{}}";
            }
            break;
        case "get_leaderboards":
            $clansget = $db->prepare("SELECT id, name, logo FROM `pgx_clans` WHERE 1");
            $clansget->bindparam(":clan", $clan);
			$clansget->execute();
			$clans = $clansget->fetchAll();
			$clanslist = "";
			//$curi = 0;
			foreach($clans as &$clandata) {
				$usersinclanget = $db->prepare("SELECT id, wins FROM `pgx_users` WHERE clan=:clan");
	            $usersinclanget->bindparam(":clan", $clandata["id"]);
				$usersinclanget->execute();
				$usersinclan = $usersinclanget->fetchAll();
				$winscountclan = 0;
				foreach($usersinclan as &$userinclan) {
					$winscountclan += $userinclan["wins"];
				}
				$clanslist .= "{\"id\":\"" . $clandata["id"] . "\", \"name\":\"" . $clandata["name"] . "\", \"logo\":\"" . $clandata["logo"] . "\", \"wins\": \"" . $winscountclan . "\"},";
				//$curi += 1;
			}
			$clanslist = substr($clanslist, 0, strlen($clanslist)-1);
			//
			$playersget = $db->prepare("SELECT id, username, wins, clan, rank FROM `pgx_users` WHERE wins > 10 ORDER BY wins DESC");
			$playersget->execute();
			$players = $playersget->fetchAll();
			$playerslist = "";
			//$curi = 0;
			foreach($players as &$playerdata) {
				$playerslist .= "{\"id\":\"" . $playerdata["id"] . "\", \"nick\":\"" . $playerdata["username"] . "\", \"wins\":\"" . $playerdata["wins"] . "\", \"rank\":\"" . $playerdata["rank"] . "\"";
				if ($playerdata["clan"] != 0) {
					$tokenget = $db->prepare("SELECT logo FROM `pgx_clans` WHERE id = :name");
			        $tokenget->bindparam(":name", $playerdata["clan"]);
			        $tokenget->execute();
			        $clanLogo = $tokenget->fetchColumn();
					$playerslist .= ", \"logo\": \"{$clanLogo}\"";
				}
				//$curi += 1;
				$playerslist .= "},";
			}
			$playerslist = substr($playerslist, 0, strlen($playerslist)-1);
			echo "{\"top_clans\": [{$clanslist}], \"best_players\": [{$playerslist}]}";
            break;
        case "get_inbox_data":
			// df096a5e516d407c3b8a721240579a9dc8c36788
        	////////////////////////////////////////////////////////////////////////////////////////////
            $tomeget = $db->prepare("SELECT id, whom, type FROM `pgx_requests` WHERE whom=:myid");
            $tomeget->bindparam(":myid", $_POST["id"]);
			$tomeget->execute();
			$tomes = $tomeget->fetchAll();
			$tomelist = "";
			//$curi = 0;
			foreach($tomes as &$request) {
				$tomelist .= "{\"who\":\"" . $request["id"] . "\", \"whom\":\"" . $request["whom"] . "\", \"id\":\"" . $request["whom"] . "\", \"status\":\"{$request["type"]}\"},";
				//$curi += 1;
			}
			////////////////////////////////////////////////////////////////////////////////////////////
			$toothersget = $db->prepare("SELECT id, whom, type FROM `pgx_requests` WHERE id=:myid");
            $toothersget->bindparam(":myid", $_POST["id"]);
			$toothersget->execute();
			$toothers = $toothersget->fetchAll();
			$tootherslist = "";
			//$curi = 0;
			foreach($toothers as &$request2) {
				$tootherslist .= "{\"who\":\"" . $request2["id"] . "\", \"whom\":\"" . $request2["whom"] . "\", \"id\":\"" . $request2["whom"] . "\", \"status\":\"{$request2["type"]}\", \"player\":\"\"},";
				//$curi += 1;
			}
			$tootherslist = substr($tootherslist, 0, strlen($tootherslist)-1);
			////////////////////////////////////////////////////////////////////////////////////////////
			$toothersget = $db->prepare("SELECT id, whom, clanid, type FROM `pgx_claninvites` WHERE whom=:myid");
            $toothersget->bindparam(":myid", $_POST["id"]);
			$toothersget->execute();
			$toothers = $toothersget->fetchAll();
			$claninvites = "";
			//$curi = 0;
			foreach($toothers as &$request2) {
				$toothersget = $db->prepare("SELECT id, name, logo FROM `pgx_clans` WHERE id=:myid");
	            $toothersget->bindparam(":myid", $request2["clanid"]);
				$toothersget->execute();
				$datas = $toothersget->fetchAll();
				foreach($datas as &$clandat) {
					$claninvites .= "{\"id\":\"" . $request2["clanid"] . "\", \"name\": \"{$clandat["name"]}\", \"logo\": \"{$clandat["logo"]}\"},";
				}
				//$curi += 1;
			}
			$claninvites = substr($claninvites, 0, strlen($claninvites)-1);
			echo "{\"friends\": [{$tomelist}{$tootherslist}], \"clans_invites\": [{$claninvites}]}";
            break;
        case "get_info_by_id":
            $userdata = $db->prepare("SELECT id, username, skin, clan, wins FROM `pgx_users` WHERE id=:myid");
            $userdata->bindparam(":myid", $_POST["id"]);
			$userdata->execute();
			$users = $userdata->fetchAll();
			$alltome = 0;
			////////////////////////////////////////////////////////////////////////////////////////////
            $tomeget = $db->prepare("SELECT id, whom, type FROM `pgx_requests` WHERE whom=:myid AND type=0");
            $tomeget->bindparam(":myid", $_POST["id"]);
			$tomeget->execute();
			$tomes = $tomeget->fetchAll();
			foreach($tomes as &$request) {
				$alltome++;
			}
			////////////////////////////////////////////////////////////////////////////////////////////
			$toothersget = $db->prepare("SELECT id, whom, type FROM `pgx_requests` WHERE id=:myid AND type=0");
            $toothersget->bindparam(":myid", $_POST["id"]);
			$toothersget->execute();
			$toothers = $toothersget->fetchAll();
			foreach($toothers as &$request2) {
				$alltome++;
			}
			////////////////////////////////////////////////////////////////////////////////////////////
			$result = [];
			foreach($users as &$user) {
				$result = [];
				$playerdata = [];
				// PLAYER DATA
				$playerdata += ["nick" => $user["username"]];
				$playerdata += ["skin" => $user["skin"]];
				$playerdata += ["total_wins" => $user["wins"]];
				$playerdata += ["friends" => $alltome];
				// FINAL RESULT SHIT
				$result += ["player" => $playerdata];
				echo json_encode($result);
			}
            break;
        case "reject_friend":
            $userdata = $db->prepare("DELETE FROM `pgx_requests` WHERE id=:id AND whom=:whom");
            $userdata->bindparam(":id", $_POST["rejector_id"]);
            $userdata->bindparam(":whom", $_POST["rejectee_id"]);
			$userdata->execute();
			echo 1;
            break;
        case "accept_friend":
            $userdata = $db->prepare("UPDATE `pgx_requests` SET `type`=1 WHERE id=:id AND whom=:whom");
            $userdata->bindparam(":id", $_POST["player_id"]);
            $userdata->bindparam(":whom", $_POST["acceptee_id"]);
			$userdata->execute();
			$userdata = $db->prepare("UPDATE `pgx_requests` SET `type`=1 WHERE id=:id AND whom=:whom");
            $userdata->bindparam(":whom", $_POST["player_id"]);
            $userdata->bindparam(":id", $_POST["acceptee_id"]);
			$userdata->execute();
			echo 1;
            break;
        case "accept_invite":
            $userdata = $db->prepare("UPDATE `pgx_users` SET `clan`=:id WHERE id=:whom");
            $userdata->bindparam(":id", $_POST["id_clan"]);
            $userdata->bindparam(":whom", $_POST["id_player"]);
			$userdata->execute();
			$userdata = $db->prepare("DELETE FROM `pgx_claninvites` WHERE whom=:id AND clanid=:whom");
            $userdata->bindparam(":id", $_POST["id_player"]);
            $userdata->bindparam(":whom", $_POST["id_clan"]);
			$userdata->execute();
			echo 1;
            break;
        case "reject_invite":
			$userdata = $db->prepare("DELETE FROM `pgx_claninvites` WHERE whom=:id AND clanid=:whom");
            $userdata->bindparam(":id", $_POST["id_player"]);
            $userdata->bindparam(":whom", $_POST["id_clan"]);
			$userdata->execute();
			echo 1;
            break;
        case "exit_clan":
			$userdata = $db->prepare("UPDATE `pgx_users` SET `clan`=0 WHERE id=:whom");
            $userdata->bindparam(":whom", $_POST["id_player"]);
			$userdata->execute();
			echo 1;
            break;
        case "get_all_short_info_by_id":
        	$requestedids = json_decode($_POST["ids"]);
        	$finaldata = "{";
        	foreach($requestedids as &$reqid) {
	            $userdata = $db->prepare("SELECT id, username, skin, clan, rank, wins FROM `pgx_users` WHERE id=:myid");
	            $userdata->bindparam(":myid", $reqid);
				$userdata->execute();
				$users = $userdata->fetchAll();
				foreach($users as &$user) {
					$finaldata .= "\"{$reqid}\":{\"friend\": \"{$user["id"]}\", \"player\":{\"nick\": \"{$user["username"]}\", \"skin\":\"{$user["skin"]}\", \"total_wins\": \"{$user["wins"]}\", \"rank\": \"{$user["rank"]}\"}},";
				}
			}
			$finaldata = substr($finaldata, 0, strlen($finaldata)-1);
			$finaldata .= "}";
			echo $finaldata;
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
			$tokenget = $db->prepare("UPDATE `pgx_users` SET `username`=:nick, `skin`=:skin, `coins`=:coins, `gems`=:gems, `wins`=:wins, `rank`=:rank WHERE id = :id");
            $tokenget->bindparam(":id", $id);
			$tokenget->bindparam(":nick", $nick);
			$tokenget->bindparam(":skin", $skin);
			$tokenget->bindparam(":coins", $_POST["coins"]);
			$tokenget->bindparam(":gems", $_POST["gems"]);
			$tokenget->bindparam(":wins", $_POST["total_wins"]);
			$tokenget->bindparam(":rank", $_POST["rank"]);
            $tokenget->execute();
			echo 1;
			break;
		case "change_clan_name":
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("UPDATE `pgx_clans` SET `name`=:logo WHERE id = :id");
            $tokenget->bindparam(":id", $_POST["id_clan"]);
			$tokenget->bindparam(":logo", $_POST["name"]);
            $tokenget->execute();
			echo 1;
			break;
		case "friend_request":
			// NOT IFNIHED
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("INSERT INTO `pgx_requests` (`id`, `whom`, `type`) VALUES (:id, :whom, '0');");
            $tokenget->bindparam(":id", $_POST["id"]);
			$tokenget->bindparam(":whom", $_POST["whom"]);
            $tokenget->execute();
			echo 1;
			break;
		case "invite_to_clan":
			// NOT IFNIHED
			// logo
			// INSERT INTO `pgx_clans` (`id`, `pid`, `name`, `logo`, `pid2`, `originver`) VALUES (NULL, '1', 'HELL GAY GAMING', 'aa', '1', '10.3.0');
			// UPDATE `pgx_users` SET `clan`=3 WHERE id = 0
			$tokenget = $db->prepare("INSERT INTO `pgx_claninvites` (`id`, `whom`, `clanid`, `type`) VALUES (:id, :whom, :clan, '0');");
            $tokenget->bindparam(":id", $_POST["id"]);
			$tokenget->bindparam(":whom", $_POST["id_player"]);
			$tokenget->bindparam(":clan", $_POST["id_clan"]);
            $tokenget->execute();
			echo 1;
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