<?php
    include "/home/GGDPS0001/public_html/sdloader/lib/connection.php";
    function GetDBVarOne($table, $thing, $where, $params1)
    {
        $tokenget = $db->prepare("SELECT " . $thing . " FROM `" . $table . "` " . $where);
        foreach ($params as $param => $link)
        {
            $tokenget->bindparam($param, $link);
        }
        $tokenget->execute();
        $token = $tokenget->fetchColumn();
        return $token;
    }
?>
